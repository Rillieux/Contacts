//
//  NewCategorySheet.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI
import CoreData

struct NewCategorySheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: NewCategorySheet.ViewModel
    
    @State private var name = ""
    @State private var color: UIColor = .gray
    
    let sortOrder: Int
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""
    
    let dismissAction: () -> Void
    let radius: CGFloat = 45.0
    
    var body: some View {
        
        let colorBinding = Binding(
            get: { Color((self.color)) },
            set: { self.color = UIColor($0) }
        )
        
        NavigationView {
            VStack{
                HStack {
                    Button(
                        action: self.dismissAction,
                        label: { Text("Cancel") }
                        )
                    Spacer()
                    addCategoryButton
                }
                .foregroundColor(.accentColor)
                .padding(.horizontal)
                .padding(.top)
                List {
                    TextField("Name", text: $name)
                    HStack {
                        Circle()
                            .frame(width: radius, height: radius)
                            .foregroundColor(Color(color))
                        ColorPicker("", selection: colorBinding)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarHidden(true)
        }
    }
    
    private var addCategoryButton: some View {
        Button(
            action: {
                viewModel.addCategory(name: name, color: color, sortOrder: sortOrder)
                dismissAction()
            },
            label: { Text("Save") })
    }
}



struct NewCategorySheet_Previews: PreviewProvider {
    static var previews: some View {
        NewCategorySheet(viewModel: NewCategorySheet.ViewModel(), sortOrder: 100, dismissAction:{})
    }
}
