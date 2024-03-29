//
//  ProfileImage+Helper.swift
//  Contacts
//
//  Created by Dave Kondris on 28/11/21.
//

import Foundation
import CoreData
import SwiftUI
import PhotoSelectAndCrop

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
            originalImage_ = newValue?.jpegData(compressionQuality: 1)
        }
    }
    
    func attributes() -> ImageAttributes {
        if image != nil && originalImage != nil {
            let imageAttributes =
            ImageAttributes(
                image: Image(uiImage: image!),
                originalImage: originalImage,
                croppedImage: image,
                scale: scale, xWidth: xWidth, yHeight: yHeight)
            return imageAttributes
        } else {
            return ImageAttributes(withSFSymbol: imagePlaceholder)
        }
    }
}
