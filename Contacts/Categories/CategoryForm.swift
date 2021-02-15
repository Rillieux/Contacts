//
//  CategoryForm.swift
//  Contact
//
//  Created by Dave Kondris on 14/02/21.
//

import CoreData // needed for preview
import SwiftUI

struct CategoryForm: View {

    @StateObject var viewModel: CategoryForm.ViewModel
    
    init(viewModel: CategoryForm.ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State private var isEditing = false
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    let radius: CGFloat = 45.0
    
    var body: some View {
    
        let colorBinding = Binding(
            get: { Color((viewModel.color)) },
            set: { viewModel.color = UIColor($0) }
                )

        VStack {
            if !isEditing {
                VStack {
                    ZStack {
                        HStack{
                            Circle()
                                .frame(width: radius, height: radius)
                                .foregroundColor(Color(viewModel.color))
                            Spacer()
                        }
                        .padding(.leading)
                        Text("\(viewModel.name)")
                            .font(.system(.title, design: .rounded))
                    }
                    .padding(.vertical, 12)
                    
//                    if viewModel.contacts?.count != 0 {
//                        List {
//                            Section (header: Text("Contacts")) {
//                                ForEach(viewModel.contacts) { contact in
//                                    HStack (spacing: 4) {
//                                        Image(systemName: "person.crop.circle.fill")
//                                        Text("\(contact.firstName)")
//                                        Text("\(contact.lastName)")
//                                        Spacer()
//                                    }
//                                }
//                            }
//                        }
//                        .listStyle(InsetGroupedListStyle())
//                    }
                    Spacer()
                }
            } else {
                List {
                    TextField("Name", text: $viewModel.name)
                    HStack {
                        Circle()
                            .frame(width: radius, height: radius)
                            .foregroundColor(Color(viewModel.color))
                        ColorPicker("", selection: colorBinding)
                    }
                }
                .listStyle(GroupedListStyle())
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
                                    if isEditing { viewModel.saveCategory() }
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
            content: { Alert(title: Text(errorAlertTitle)) }) }
    
}

//struct CategoryForm_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryForm(viewModel: CategoryForm.ViewModel(category: category))
//    }
//}
