//
//  ImageMoveAndScaleSheet.swift
//  PhotoSelectAndCrop
//
//  Created by Dave Kondris on 03/01/21.
//

import SwiftUI

struct ImageMoveAndScaleSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.verticalSizeClass) var sizeClass
    
    @EnvironmentObject var deviceOrientation: DeviceOrientation
    
    @State private var isShowingImagePicker = false
    
    ///The cropped image is what will will send back to the parent view.
    ///It should be the part of the image in the square defined by the
    ///cutout circle's diamter. See below, the cutout circle has an "inset" value
    ///which can be changed.
    @Binding var originalImage: UIImage?
    @Binding var originalPosition: CGSize?
    @Binding var originalZoom: CGFloat?
    
    @Binding var processedImage: UIImage?
    
    ///The input image is received from the ImagePicker.
    ///We will need to calculate and refer to its aspectr ratio in the functions.
    @State var inputImage: UIImage?
    @State var inputImageAspectRatio: CGFloat = 0.0
    
    ///The displayImage is what wee see on this view. When added from the
    ///ImapgePicker, it will be sized to fit the screen,
    ///meaning either its width will match the width of the device's screen,
    ///or its height will match the height of the device screen.
    ///This is not suitable for landscape mode or for iPads.
    @State var displayImage: UIImage?
    @State var displayW: CGFloat = 0.0
    @State var displayH: CGFloat = 0.0
    
    ///Zoom and Drag ...
    @State var currentAmount: CGFloat = 0
    @State var zoomAmount: CGFloat = 1.0
    @State var currentPosition: CGSize = .zero
    @State var newPosition: CGSize = .zero
    @State var horizontalOffset: CGFloat = 0.0
    @State var verticalOffset: CGFloat = 0.0
    
    ///Local variables
    let inset: CGFloat = 15
    
    var body: some View {
        
        ZStack {
            ZStack {
                Color.black.opacity(0.8)
                if displayImage != nil {
                    Image(uiImage: displayImage!)
                        .resizable()
                        .scaleEffect(zoomAmount + currentAmount)
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .clipped()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.systemGray2)
                        .padding(inset)
                }
                
            }
            
            Rectangle()
                .fill(Color.black).opacity(0.55)
                .mask(HoleShapeMask().fill(style: FillStyle(eoFill: true)))
            

            VStack {
                Text((displayImage != nil) ? "Move and Scale" : "Select a photo by tapping the icon below")
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .opacity((deviceOrientation.orientation == .portrait) ? 1.0 : 0.0)
                Spacer()
                HStack{
                    ZStack {
                        HStack {
                            cancelButton
                            Spacer()
                            if deviceOrientation.orientation == .landscape {
                                openSystemPickerButton
                                    .padding(.trailing, 20)
                            }
                            saveButton
                        }
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        if deviceOrientation.orientation == .portrait {
                            openSystemPickerButton
                        }
                    }
                }
            }
            .padding(.bottom, (deviceOrientation.orientation == .portrait) ? 20 : 4)
        }
        .edgesIgnoringSafeArea(.all)
        
        //MARK: - Gestures
        
        .gesture(
            MagnificationGesture()
                .onChanged { amount in
                    self.currentAmount = amount - 1
                }
                .onEnded { amount in
                    self.zoomAmount += self.currentAmount
                    if zoomAmount > 4.0 {
                        withAnimation {
                            zoomAmount = 4.0
                        }
                    }
                    self.currentAmount = 0
                    withAnimation {
                        repositionImage()
                    }
                }
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                }
                .onEnded { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                    self.newPosition = self.currentPosition
                    withAnimation {
                        repositionImage()
                    }
                }
        )
        .simultaneousGesture(
            TapGesture(count: 2)
                .onEnded(  { resetImageOriginAndScale() } )
        )
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            SystemImagePicker(image: self.$inputImage)
                .accentColor(Color.systemRed)
        }
        .onAppear(perform: setCurrentImage )
    }
    
    ///Code for mask obtained here:
    ///https://stackoverflow.com/questions/59656117/swiftui-add-inverted-mask
    
    func HoleShapeMask() -> Path {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let insetRect = CGRect(x: inset, y: inset, width: UIScreen.main.bounds.width - ( inset * 2 ), height: UIScreen.main.bounds.height - ( inset * 2 ))
        var shape = Rectangle().path(in: rect)
        shape.addPath(Circle().path(in: insetRect))
        return shape
    }
    
    //MARK: - Buttons, Labels
    
    private var cancelButton: some View {
        Button(
            action: {presentationMode.wrappedValue.dismiss()},
            label: { Text("Cancel") })
    }
    
    private var openSystemPickerButton: some View {
        ZStack {
            Image(systemName: "circle.fill")
                .font(.custom("system", size: 45))
                .opacity(0.9)
                .foregroundColor( ( displayImage == nil ) ? .systemGreen : .white)
            Image(systemName: "photo.on.rectangle")
                .imageScale(.medium)
                .foregroundColor(.black)
                .onTapGesture {
                    isShowingImagePicker = true
                }
        }
    }
    
    private var saveButton: some View {
        Button(
            action: {
                self.processImage()
                
                //TODO: - Save code here
                
                presentationMode.wrappedValue.dismiss()
            })
            { Text("Save") }
            .opacity((displayImage != nil) ? 1.0 : 0.2)
            .disabled((displayImage != nil) ? false: true)
    }
}

