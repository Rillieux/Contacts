//
//  ContactImage+Helper.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import Foundation
import CoreData
import UIKit

extension ContactImage {
    var scale: CGFloat {
        get {
            return CGFloat(scale_)
        }
        set {
            scale_ = Double(newValue)
        }
    }
    
    var position: CGSize {
        let x = CGFloat(xWidth)
        let y = CGFloat(yHeight)
        let point = CGSize(width: x,height: y)
        return point
    }
    
    var image: UIImage {
        get {
            return imageFromData(image_!)
            }
        set {
            image_ = dataFromImage(newValue)
        }
    }
    
    var originalImage: UIImage {
        get {
            return imageFromData(originalImage_!)
            }
        set {
            originalImage_ = dataFromImage(newValue)
        }
    }
}
