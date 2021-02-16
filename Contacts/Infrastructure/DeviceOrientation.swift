//
//  DeviceOrientation.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import Combine
import UIKit

final class DeviceOrientation: ObservableObject {
    
    enum Orientation {
        case portrait
        case landscape
    }
    
    @Published private(set) var orientation: Orientation = UIDevice.current.orientation.isLandscape ? .landscape : .portrait
    
    init() {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { notification -> Orientation? in
                guard let device = notification.object as? UIDevice else { return nil }
                let deviceOrientation = device.orientation
                if deviceOrientation.isPortrait {
                    return .portrait
                } else if deviceOrientation.isLandscape {
                    return .landscape
                } else {
                    return nil
                }
            }
            .assign(to: &$orientation)
    }
}
