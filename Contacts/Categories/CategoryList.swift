//
//  CategoryList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct CategoryList: View {
    @StateObject var viewModel: CategoryList.ViewModel
    @State private var newName: String = ""
    init(viewModel: CategoryList.ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            List{
                HStack {
                    TextField("Name", text: $newName)
                        .padding(.horizontal)
                        .padding(.top)
                    Button(action: {
                        withAnimation {
                            viewModel.addCategory(name: newName)
                            newName = ""
                        }
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    })
                    .frame(width: 24, height: 24)
                    .background(Color.red)
                    .cornerRadius(6)
                }
                ForEach(viewModel.categories) { category in
                    Text("\(category.name)")
                }
                .onMove(perform: { indices, newOffset in
                    viewModel.moveCategories(from: indices, to: newOffset)
                })
                .onDelete(perform: { indexSet in
                    viewModel.deleteCategories(offsets: indexSet)
                })
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: viewModel.updateCategories)
            .navigationBarItems(trailing: EditButton())
            .navigationTitle("Items")
        }
    }
}


struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
