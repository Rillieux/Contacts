//
//  ContactProfile.swift
//  Contact
//
//  Created by Dave Kondris on 26/01/21.
//

import SwiftUI

struct ContactProfile: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var contact: Contact
    
    @FetchRequest(fetchRequest: Category.fetchRequest(.all)) var categories: FetchedResults<Category>
    
    @State private var isEditing = false
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    ///Photo Selection
    @State private var isShowingPhotoSelectionSheet = false
    
    //viewModel vars
    @State private var originalImage: UIImage?
    @State private var zoom: CGFloat?
    @State private var position: CGSize?
    @State private var inputImage: UIImage?
    
    init(contact: Contact) {
        self.contact = contact
        self._originalImage = State(initialValue: contact.picture?.originalImage)
        self._zoom = State(initialValue: CGFloat(contact.picture?.scale ?? 1.0))
        self._position = State(initialValue: contact.picture?.position)
    }
    
    @State private var photoSize: CGFloat = 72.0
    
    ///Offset the deafult date by minus 18 years.
    let defaultDOB: Date = Calendar.current.date(byAdding: DateComponents(year: -18), to: Date()) ?? Date()
    let dotDiameter: CGFloat = 8
    
    var body: some View {
        
        VStack {
            VStack {
                if contact.picture != nil {
                    Image(uiImage: (contact.picture?.image)!)  /// unexpected nil of course
                        .resizable()
                        .frame(width: self.photoSize, height: self.photoSize)
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.photoSize, height: self.photoSize)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.systemGray2)
                }
                if isEditing {
                    Button (action: {
                        self.isShowingPhotoSelectionSheet = true
                        self.getSqlitepath()
                    }, label: {
                        Text("Change photo")
                            .foregroundColor(.systemRed)
                            .font(.footnote)
                    })
                }
            }
            .padding(.top)
            
            if !isEditing {
                Text("\(contact.firstName) \(contact.lastName)")
                    .font(.largeTitle)
                    .padding(.top)
                if contact.birthdate != nil {
                    Text("\(contact.birthdate!, formatter: dobFormatter) - \(contact.age!)")
                }
                HStack {
                    Circle().fill(Color((contact.category?.color ?? .gray)))
                        .frame(width: dotDiameter * 1.5, height: dotDiameter * 1.5)
                    Text("\(contact.category?.name ?? "Unassigned")")
                }
                Spacer()
            } else {
                Form{
                    TextField("First Name", text: $contact.firstName)
                    TextField("Last Name", text: $contact.lastName)
                    DatePicker(selection: $contact.birthdate ?? defaultDOB, in: ...Date(), displayedComponents: .date) {
                        Text( contact.birthdate != nil ? "Change birthdate" : "Pick birthdate" )
                    }
                    
                    Picker("Category", selection: $contact.category) {
                        ///We add this view so we can "nullify" a contact's category.
                        ///See Stanford University's course CS193p, lectures 11 and 12:
                        ///https://cs193p.sites.stanford.edu/
                        Text("Unassigned").tag(Category?.none)
                        ForEach(categories) { (category: Category?) in
                            HStack {
                                Circle().fill(Color((category?.color)!))
                                    .frame(width: dotDiameter, height: dotDiameter)
                                Text("\(category?.name ?? "Unassigned")")
                            }
                            .tag(category)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(isEditing ? true : false)
        .navigationBarItems(leading:
                                Button (action: {
                                    contact.managedObjectContext!.refresh(contact, mergeChanges: false)
                                    withAnimation {
                                        self.isEditing = false
                                    }
                                }, label: {
                                    Text(isEditing ? "Cancel" : "")
                                }),
                            trailing:
                                Button (action: {
                                    if isEditing { saveContact() }
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
        .fullScreenCover(isPresented: $isShowingPhotoSelectionSheet, onDismiss: {loadImage(contact: contact)}) {
            ImageMoveAndScaleSheet(originalImage: $originalImage, originalPosition: $position, originalZoom: $zoom, processedImage: $inputImage)
                .environmentObject(DeviceOrientation())
        }
    }
    
    func loadImage(contact: Contact) {

        //TODO: - figure out what is going on here
        
        guard let inputImage = inputImage else { return }
        
        contact.picture?.image = inputImage
        if originalImage != nil {
            contact.picture?.originalImage = originalImage!
        }
        if zoom != nil {
            contact.picture?.scale = zoom!
        }
        if position != nil {
            contact.picture?.xWidth = Double(position!.width)
            contact.picture?.yHeight = Double(position!.height)
        }

    }
    
    private func getSqlitepath() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
    
    private func saveContactImage() {
        
        guard let inputImage = inputImage else { return }
        
        if contact.picture != nil {
            contact.picture!.image = inputImage
            contact.picture!.originalImage = originalImage!
            contact.picture!.scale = zoom!
            contact.picture!.xWidth = Double(position!.width)
            contact.picture!.yHeight = Double(position!.height)
            
        } else {
            
            let newContactImage = ContactImage(context: contact.managedObjectContext!)
            
            if originalImage != nil && zoom != nil && position != nil {
                newContactImage.image = inputImage
                newContactImage.originalImage = originalImage!
                newContactImage.scale = zoom!
                newContactImage.xWidth = Double(position!.width)
                newContactImage.yHeight = Double(position!.height)
                newContactImage.contact = contact
            }
        }
        
        do {
            try viewContext.save()
            viewContext.refresh(contact, mergeChanges: true)
        } catch {
            errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
            errorAlertIsPresented = true
        }
    }
    
    private func saveContact() {
        saveContactImage()
        do {
            if contact.firstName.isEmpty {
                throw ValidationError.missingFirstName
            }
            if contact.lastName.isEmpty {
                throw ValidationError.missingLastName
            }
            try contact.managedObjectContext!.save()
            viewContext.refresh(contact, mergeChanges: true)
        } catch {
            errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
            errorAlertIsPresented = true
        }
    }
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

