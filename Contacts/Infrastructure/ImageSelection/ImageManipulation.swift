//
//  ImageManipulation.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import UIKit

func dataFromImage (_ uiImage: UIImage) -> Data {
    let data = uiImage.jpegData(compressionQuality: 1.0) ?? Data.init()
        return data
}

func imageFromData (_ data: Data) -> UIImage {
    guard let image = UIImage(data: data) else { return UIImage(named: "portrait")! }
    return image
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

func croppedImage(from image: UIImage, croppedTo rect: CGRect) -> UIImage {

    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()

    let drawRect = CGRect(x: -rect.origin.x, y: -rect.origin.y, width: image.size.width, height: image.size.height)

    context?.clip(to: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))

    image.draw(in: drawRect)

    let subImage = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()
    return subImage!
}


