//
//  ContactProfile.swift
//  Contact
//
//  Created by Dave Kondris on 26/01/21.
//

import CoreData // needed for preview
import SwiftUI

struct ContactProfile: View {

    @StateObject var viewModel: ContactProfile.ViewModel
    
    init(viewModel: ContactProfile.ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    

    @State private var isEditing = false
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    ///Photo Selection
    @State private var isShowingPhotoSelectionSheet = false

    @State private var photoSize: CGFloat = 72.0
    
    let dotDiameter: CGFloat = 8
    
    var body: some View {
        
        VStack {
//            VStack {
//                if contact.picture != nil {
//                    Image(uiImage: (contact.picture?.image)!)  /// unexpected nil of course
//                        .resizable()
//                        .frame(width: self.photoSize, height: self.photoSize)
//                        .scaledToFill()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(Circle())
//                        .shadow(radius: 4)
//                } else {
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: self.photoSize, height: self.photoSize)
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.systemGray2)
//                }
//                if isEditing {
//                    Button (action: {
//                        self.isShowingPhotoSelectionSheet = true
//                        self.getSqlitepath()
//                    }, label: {
//                        Text("Change photo")
//                            .foregroundColor(.systemRed)
//                            .font(.footnote)
//                    })
//                }
//            }
//            .padding(.top)
            
            if !isEditing {
                Text("\(viewModel.firstName) \(viewModel.lastName)")
                    .font(.largeTitle)
                    .padding(.top)
                if viewModel.birthdate != nil {
                    Text("\(viewModel.birthdate!, formatter: dobFormatter) - \(viewModel.contact.age ?? "")")
                }
//                HStack {
//                    Circle().fill(Color((contact.category?.color ?? .gray)))
//                        .frame(width: dotDiameter * 1.5, height: dotDiameter * 1.5)
//                    Text("\(contact.category?.name ?? "Unassigned")")
//                }
                Spacer()
            } else {
                Form{
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
//                    DatePicker(selection: $contact.birthdate ?? defaultDOB, in: ...Date(), displayedComponents: .date) {
//                        Text( contact.birthdate != nil ? "Change birthdate" : "Pick birthdate" )
//                    }
                    
//                    Picker("Category", selection: $contact.category) {
//                        ///We add this view so we can "nullify" a contact's category.
//                        ///See Stanford University's course CS193p, lectures 11 and 12:
//                        ///https://cs193p.sites.stanford.edu/
//                        Text("Unassigned").tag(Category?.none)
//                        ForEach(categories) { (category: Category?) in
//                            HStack {
//                                Circle().fill(Color((category?.color)!))
//                                    .frame(width: dotDiameter, height: dotDiameter)
//                                Text("\(category?.name ?? "Unassigned")")
//                            }
//                            .tag(category)
//                        }
//                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(isEditing ? true : false)
        .navigationBarItems(leading:
                                Button (action: {
                                    viewModel.refreshWithNoChanges()
                                    withAnimation {
                                        self.isEditing = false
                                    }
                                }, label: {
                                    Text(isEditing ? "Cancel" : "")
                                }),
                            trailing:
                                Button (action: {
                                    if isEditing { viewModel.saveContact() }
                                    withAnimation {
                                        if !errorAlertIsPresented {
                                            self.isEditing.toggle()
                                        }
                                    }
                                }, label: {
                                    Text(!isEditing ? "Edit" : "Done")
                                })
        )
        .alert(
            isPresented: $errorAlertIsPresented,
            content: { Alert(title: Text(errorAlertTitle)) })
        .statusBar(hidden: isShowingPhotoSelectionSheet)
//        .fullScreenCover(isPresented: $isShowingPhotoSelectionSheet, onDismiss: {loadImage(contact: contact)}) {
//            ImageMoveAndScaleSheet(originalImage: $originalImage, originalPosition: $position, originalZoom: $zoom, processedImage: $inputImage)
//                .environmentObject(DeviceOrientation())
//        }
    }
    
//    func loadImage(contact: Contact) {
//
//        //TODO: - figure out what is going on here
//
//        guard let inputImage = inputImage else { return }
//
//        contact.picture?.image = inputImage
//        if originalImage != nil {
//            contact.picture?.originalImage = originalImage!
//        }
//        if zoom != nil {
//            contact.picture?.scale = zoom!
//        }
//        if position != nil {
//            contact.picture?.xWidth = Double(position!.width)
//            contact.picture?.yHeight = Double(position!.height)
//        }
//
//    }
    


}

extension ContactProfile {
    enum ValidationError: LocalizedError {
        case missingFirstName
        case missingLastName
        var errorDescription: String? {
            switch self {
                case .missingFirstName:
                    return "Please enter a first name for this contact."
                case .missingLastName:
                    return "Please enter a last name for this contact."
            }
        }
    }
}

