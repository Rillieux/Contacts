//
//  ImageAttributeStructs.swift
//  Contacts
//
//  Created by Dave Kondris on 06/10/21.
//

import PhotoSelectAndCrop
import SwiftUI

let contactImagePlaceholder = ImageAttributes(withSFSymbol: "book.circle.fill")

func createImageAttributes(from contactImage: ProfileImage) -> ImageAttributes {
    return ImageAttributes(image: Image(uiImage: (contactImage.image!)), originalImage: contactImage.originalImage, scale: contactImage.scale, xWidth: contactImage.xWidth, yHeight: contactImage.yHeight)
}
