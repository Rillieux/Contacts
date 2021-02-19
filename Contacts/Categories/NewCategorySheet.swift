//
//  NewCategorySheet.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct NewCategorySheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: NewCategorySheet.ViewModel
    
    let sortOrder: Int
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    let dismissAction: () -> Void
    let radius: CGFloat = 45.0
    
    var body: some View {
        
        let colorBinding = Binding(
            get: { Color((viewModel.color)) },
            set: { viewModel.color = UIColor($0) }
        )
        
        NavigationView {
            VStack{
                HStack {
                    cancelButton
                    Spacer()
                    addCategoryButton
                }
                .foregroundColor(Color("AccentColor"))
                .padding(.horizontal)
                .padding(.top)
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
    
    private var addCategoryButton: some View {
        Button(
            action: {
                do {
                    try viewModel.addCategory(sortOrder: sortOrder)
                    dismissAction()
                } catch {
                    errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
                    errorAlertIsPresented = true
                }
            },
            label: { Text("Save") })
    }
}

struct NewCategorySheet_Previews: PreviewProvider {
    static var previews: some View {
        NewCategorySheet(viewModel: NewCategorySheet.ViewModel(), sortOrder: 100, dismissAction:{})
    }
}

