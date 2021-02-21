//
//  LevelList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct LevelList: View {
    @StateObject var viewModel: LevelList.ViewModel
    
    ///This approach to the viewModel as an extension of the view was applied from
    ///Kilo Loco's Youtube tutorial that can be found here: https://www.youtube.com/watch?v=bdqEcpppAMc
    init(viewModel: LevelList.ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State private var showingNewLevelSheet = false
    
    let dotDiameter: CGFloat = 8
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(viewModel.levels) { level in
                    NavigationLink (
                        destination: LevelForm(viewModel: LevelForm.ViewModel(level: level))) {
                        HStack (alignment: .center) {
                            Circle().fill(Color(level.color))
                                .frame(width: dotDiameter, height: dotDiameter)
                            HStack (alignment: .firstTextBaseline) {
                                Text("\(level.name)")
                                Text("(Sort order: \(level.sortOrder))").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onMove(perform: { indices, newOffset in
                    viewModel.moveLevels(from: indices, to: newOffset)
                })
                .onDelete(perform: { indexSet in
                    viewModel.deleteLevels(offsets: indexSet)
                })
            }
            .listStyle(PlainListStyle())
            .onAppear(perform: viewModel.updateLevels)
            .navigationTitle("Levels")
            .navigationBarItems(trailing: HStack {
                EditButton()
                addLevelButton
            }
            )
        }
    }
    
    private var addLevelButton: some View {
        Button(
            action: {
                self.showingNewLevelSheet = true
            },
            label: { Image(systemName: "plus").imageScale(.large) })
            .sheet(
                isPresented: $showingNewLevelSheet,
                content: { self.newLevelSheet }
            )
    }
    
    /// The level creation sheet.
    private var newLevelSheet: some View {
        ///When we add a new level, we want it to initially show up last in the list.
        ///To achieve this, we get the count of the levels and
        ///send that Int to the NewLevelheet.
        NewLevelSheet(viewModel: NewLevelSheet.ViewModel(), sortOrder: viewModel.levels.count, dismissAction: {
            self.showingNewLevelSheet = false
            viewModel.updateLevels()
        }
        )
    }
}


struct LevelList_Previews: PreviewProvider {
    static var previews: some View {
        LevelList()
    }
}
