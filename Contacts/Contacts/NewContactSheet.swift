//
//  NewContactSheet.swift
//  Contact
//
//  Created by Dave Kondris on 26/01/21.
//

import SwiftUI
import CoreData


struct NewContactSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: NewContactSheet.ViewModel
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    let dismissAction: () -> Void
    let dotDiameter: CGFloat = 8
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    cancelButton
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
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 180, height: 180)
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
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                    
                    ///Optional date handling asnwer from StackOverflow:
                    ///https://stackoverflow.com/questions/59272801/swiftui-datepicker-binding-optional-date-valid-nil
                    DatePicker(selection: Binding<Date>(get: {self.viewModel.birthdate ?? defaultBirthDate()}, set: {self.viewModel.birthdate = $0}), displayedComponents: .date) {
                        Text("Birthdate")
                    }
                    .accentColor(.systemRed)
                    
//                    Picker("Category", selection: $viewModel.category) {
//                        ///We add this view so we can "nullify" a contact's category.
//                        ///See Stanford University's course CS193p, lectures 11 and 12:
//                        ///https://cs193p.sites.stanford.edu/
//                        Text("Unassigned").tag(Category?.none)
//                        ForEach(viewModel.categories) { (category: viewModel.Category?) in
//                            HStack {
//                                Circle().fill(Color((category?.color)!))
//                                    .frame(width: dotDiameter, height: dotDiameter)
//                                Text("\(category?.name ?? "Unassigned")")
//                            }
//                            .tag(category)
//                        }
//                        
//                    }
                }
                .listStyle(GroupedListStyle())
                
                
            }
            .navigationBarHidden(true)
            .alert(
                isPresented: $errorAlertIsPresented,
                content: { Alert(title: Text(errorAlertTitle)) })
        }
        
    }
    
    private var cancelButton: some View {
        Button(
            action: self.dismissAction,
            label: { Text("Cancel") }
        )
    }
    
    private var addContactButton: some View {
        Button(
            action: {
                do {
                    try viewModel.addContact()
                    dismissAction()
                } catch {
                    errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
                    errorAlertIsPresented = true
                }
            },
            label: { Text("Save") })
    }
}

struct AddContactSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewContactSheet(viewModel: NewContactSheet.ViewModel(), dismissAction:{})
    }
}
