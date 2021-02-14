//
//  CategoryForm.swift
//  Contact
//
//  Created by Dave Kondris on 23/01/21.
//

import SwiftUI

struct CategoryForm: View {

    @StateObject var viewModel: CategoryForm.ViewModel
    
    ///We use the State var myColor, because using category.color in the colorBinding
    ///results in odd behavious in the color pickers sliders.
    
//    @State private var myColor: UIColor
        
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
                                ///Because we init myColor above, we can show the category.color passing through mycolor.
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
                        Spacer()
                        ColorPicker("Tap here to edit color:", selection: colorBinding)
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
