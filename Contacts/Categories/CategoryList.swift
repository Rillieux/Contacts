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
    
    @State private var showingNewCategorySheet = false
    
    let dotDiameter: CGFloat = 8
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(viewModel.categories) { category in
                    NavigationLink (
                        destination: CategoryForm(viewModel: CategoryForm.ViewModel(category: category))) {
                        HStack (alignment: .center) {
                            Circle().fill(Color(category.color))
                                .frame(width: dotDiameter, height: dotDiameter)
                            HStack (alignment: .firstTextBaseline) {
                                Text("\(category.name)")
                                Text("Sort order: \(category.sortOrder)").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
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
            .navigationTitle("Categories")
            .navigationBarItems(trailing: HStack {
                EditButton()
                addCategoryButton
            }
            )
        }
    }
    
    private var addCategoryButton: some View {
        Button(
            action: {
                self.showingNewCategorySheet = true
            },
            label: { Image(systemName: "plus").imageScale(.large) })
            .sheet(
                isPresented: $showingNewCategorySheet,
                content: { self.newCategorySheet }
            )
    }
    
    /// The category creation sheet.
    private var newCategorySheet: some View {
        NewCategorySheet(viewModel: NewCategorySheet.ViewModel(), sortOrder: viewModel.categories.count, dismissAction: {
            self.showingNewCategorySheet = false
            viewModel.updateCategories()
        }
        )
    }
    
}


struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
