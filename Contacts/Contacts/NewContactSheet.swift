//
//  NewContactSheet.swift
//  Contact
//
//  Created by Dave Kondris on 26/01/21.
//

import SwiftUI
import CoreData


struct NewContactSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
   
    @FetchRequest(fetchRequest: Category.fetchRequest(.all)) var categories: FetchedResults<Category>
    
    @State private var firstName = ""
    @State private var lastName = ""
    
    @State private var birthdate: Date = Calendar.current.date(byAdding: DateComponents(year: -18), to: Date()) ?? Date()
    
    @State private var category: Category?
    
    let dismissAction: () -> Void
    let dotDiameter: CGFloat = 8
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Button(
                        action: self.dismissAction,
                        label: { Text("Cancel") })
                    Spacer()
                    addContactButton
                }
                .foregroundColor(.systemRed)
                .padding(.horizontal)
                .padding(.top)
                ZStack {
                    Circle()
                        .fill(Color(.systemIndigo).opacity(0.35))
                        .frame(width: 180, height: 180)
//                    Text("AS")
//                        .font(.system(size: 112.0, weight: .regular, design: .rounded))
//                        .foregroundColor(.white).opacity(0.55)
                    Image(systemName: "photo.on.rectangle")
                            .resizable()
                            .scaledToFit()
                        .padding()
                            .frame(width: 180, height: 180)
//                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .padding(.top, -20)
                .padding(.bottom, 10)


                Button (action: {
    //                self.isShowingPhotoSelectionSheet = true
                }, label: {
                    Text("Change photo")
                        .foregroundColor(.systemRed)
                        .font(.footnote)
                })
                Form {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker(selection: $birthdate, in: ...Date(), displayedComponents: .date) {
                        Text("Birthdate")
                    }
                    .accentColor(.systemRed)
                    
                    Picker("Category", selection: $category) {
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
                .listStyle(GroupedListStyle())

                
            }
            .navigationBarHidden(true)
        }
        
    }
    
    /// The button that presents the contact creation sheet.
    private var addContactButton: some View {
                Button(
            action: {
                saveContact()
            },
            label: { Text("Save") })
    }
    
    private func saveContact(){
        
        let newContact = Contact(context: viewContext)
        
        newContact.firstName = firstName
        newContact.lastName = lastName
        newContact.birthdate = birthdate
        newContact.category = category
        do {
            try self.viewContext.save()
            dismissAction()
        } catch {
        }
        
    }
}

struct AddContactSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewContactSheet(dismissAction: { })
    }
}
