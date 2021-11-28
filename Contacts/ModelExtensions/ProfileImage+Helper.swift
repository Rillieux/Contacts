//
//  ProfileImage+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 28/11/21.
//

import Foundation
import CoreData
import SwiftUI

extension ProfileImage {
    var image: UIImage? {
        get {
            let tempImage: UIImage? = UIImage(data: image_!)
            if tempImage != nil {
                return tempImage!
            } else {
                return nil
            }
        }
        set {
            image_ = newValue?.pngData()
        }
    }
    var originalImage: UIImage? {
        get {
            let tempImage: UIImage? = UIImage(data: originalImage_!)
            if tempImage != nil {
                return tempImage!
            } else {
                return nil
            }
        }
        set {
            originalImage_ = newValue?.pngData()
        }
    }
}
