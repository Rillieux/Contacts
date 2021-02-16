//
//  ImageMoveAndScaleSheet+Extensions.swift
//  PhotoSelectAndCrop
//
//  Created by Dave Kondris on 03/01/21.
//

import SwiftUI

extension ImageMoveAndScaleSheet {
    
    ///Called when the ImagePicker is dismissed.
    ///We want to measure the image received and determine its aspect ratio.
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let w = inputImage.size.width
        let h = inputImage.size.height
        displayImage = inputImage
        inputImageAspectRatio = w / h
        resetImageOriginAndScale()
    }
    
    func setCurrentImage() {
        guard let currentImage = originalImage else { return }
        let w = currentImage.size.width
        let h = currentImage.size.height
        inputImage = currentImage
        inputImageAspectRatio = w / h
        currentPosition = originalPosition!
        newPosition = originalPosition!
        zoomAmount = originalZoom!
        displayImage = currentImage
        repositionImage()
    }
        
    ///The displayImage will size to fit the screen.
    ///But we need to know the width and height of
    ///the screen to size it appropriately.
    ///Double-tapping the image will also set it
    ///as it was sized originally upon loading.

    private func getAspect() -> CGFloat {
        let screenAspectRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        return screenAspectRatio
    }
    
    func resetImageOriginAndScale() {
        print("reposition")
        let screenAspect: CGFloat = getAspect()

        withAnimation(.easeInOut){
            if inputImageAspectRatio >= screenAspect {
                displayW = UIScreen.main.bounds.width
                displayH = displayW / inputImageAspectRatio
            } else {
                displayH = UIScreen.main.bounds.height
                displayW = displayH * inputImageAspectRatio
            }
            currentAmount = 0
            zoomAmount = 1
            currentPosition = .zero
            newPosition = .zero
        }
    }
    
    func repositionImage() {
        
        ///Setting the display width and height so the imputImage fits the screen
        ///orientation.
        let screenAspect: CGFloat = getAspect()
        let diameter = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
        if screenAspect <= 1.0 {
            if inputImageAspectRatio > screenAspect {
                displayW = diameter * zoomAmount
                displayH = displayW / inputImageAspectRatio
            } else {
                displayH = UIScreen.main.bounds.height * zoomAmount
                displayW = displayH * inputImageAspectRatio
            }
        } else {
            if inputImageAspectRatio < screenAspect {
                displayH = diameter * zoomAmount
                displayW = displayH * inputImageAspectRatio
            } else {
                displayW = UIScreen.main.bounds.width * zoomAmount
                displayH = displayW / inputImageAspectRatio
            }
        }
        
        horizontalOffset = (displayW - diameter ) / 2
        verticalOffset = ( displayH - diameter) / 2

        ///Keep the user from zooming too far in. Adjust as required by the individual project.
        if zoomAmount > 4.0 {
                zoomAmount = 4.0
        }
        
        ///If the view which presents the ImageMoveAndScaleSheet is embeded in a NavigationView then the vertical offset is off.
        ///This appears to be a SwiftUI bug. So, we "pad" the function with this "adjust". YMMV.
        let adjust: CGFloat = 4.0
        ///The following if statements keep the image filling the circle cutout
        ///in at least one dimension.
        if displayH >= diameter {
            if newPosition.height > verticalOffset {
                print("1. newPosition.height > verticalOffset")
                    newPosition = CGSize(width: newPosition.width, height: verticalOffset - adjust + inset)
                    currentPosition = CGSize(width: newPosition.width, height: verticalOffset - adjust + inset)
            }
            
            if newPosition.height < ( verticalOffset * -1) {
                print("2. newPosition.height < ( verticalOffset * -1)")
                    newPosition = CGSize(width: newPosition.width, height: ( verticalOffset * -1) - adjust - inset)
                    currentPosition = CGSize(width: newPosition.width, height: ( verticalOffset * -1) - adjust - inset)
            }
            
        } else {
            print("else: H")
                newPosition = CGSize(width: newPosition.width, height: 0)
                currentPosition = CGSize(width: newPosition.width, height: 0)
        }
        
        if displayW >= diameter {
            if newPosition.width > horizontalOffset {
                print("3. newPosition.width > horizontalOffset")
                    newPosition = CGSize(width: horizontalOffset + inset, height: newPosition.height)
                    currentPosition = CGSize(width: horizontalOffset + inset, height: currentPosition.height)
            }
            
            if newPosition.width < ( horizontalOffset * -1) {
                print("4. newPosition.width < ( horizontalOffset * -1)")
                    newPosition = CGSize(width: ( horizontalOffset * -1) - inset, height: newPosition.height)
                    currentPosition = CGSize(width: ( horizontalOffset * -1) - inset, height: currentPosition.height)

            }
            
        } else {
            print("else: W")
                newPosition = CGSize(width: 0, height: newPosition.height)
                currentPosition = CGSize(width: 0, height: newPosition.height)
        }

        ///This statement is needed in case of a screenshot.
        ///That is, in case the user chooses a photo that is the exact size of the device screen.
        ///Without this function, such an image can be shrunk to less than the
        ///size of the cutrout circle and even go negative (inversed).
        ///If "processImage()" is run in this state, there is a fatal error. of a nil UIImage.
        ///
        if displayW < diameter - inset && displayH < diameter - inset {
            resetImageOriginAndScale()
        }
    }
    
    
    ///This func saves am image correctly in portrait mode. But not in landscape.
    func processImage() {
        
        let scale = (inputImage?.size.width)! / displayW
        let originAdjustment = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let diameter = ( originAdjustment - inset * 2 ) * scale
        
        let xPos = ( ( ( displayW - originAdjustment ) / 2 ) + inset + ( currentPosition.width * -1 ) ) * scale
        let yPos = ( ( ( displayH - originAdjustment ) / 2 ) + inset + ( currentPosition.height * -1 ) ) * scale
        
        processedImage = croppedImage(from: inputImage!, croppedTo: CGRect(x: xPos, y: yPos, width: diameter, height: diameter))
        originalImage = inputImage
        originalZoom = zoomAmount
        originalPosition = currentPosition
        
        ///Debug maths
//        print("\n\n\n### SAVE ###")
//        let screenAspect = getAspect()
//
//        print("Screen: w \(UIScreen.main.bounds.width) h \(UIScreen.main.bounds.height) aspect: \(screenAspect)\n")
//        print("X Origin: \( ( ( displayW - radius - inset ) / 2 ) + ( currentPosition.width  * -1 ) )")
//        print("Y Origin: \( ( ( displayH - radius - inset) / 2 ) + ( currentPosition.height  * -1 ) )\n")
//        print("Scale: \(scale)\n")
//        print("Current Pos: \(currentPosition.debugDescription)")
//        print("Radius: \(radius)")
//        print("NewPost: \(newPosition.debugDescription)")
//        print("Final: \(zoomAmount)")
//        print("x:\(xPos), y:\(yPos)")
//        print("Offsets: hor \(horizontalOffset) ver \(verticalOffset)\n")
//        print("Input: w \(inputImage!.size.width) h \(inputImage!.size.height) aspect: \(inputImage!.size.width / inputImage!.size.height)")
//        print("Display: w \(displayW) h \(displayH) aspect: \(displayW / displayH)\n\n\n")
    }
}
