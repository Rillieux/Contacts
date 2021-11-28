//
//  LevelList.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct LevelList: View {
    
    var body: some View {
        
        NavigationView {
            List{
                Text("TODO: Levels list")
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Levels")
        }
    }
}


struct LevelList_Previews: PreviewProvider {
    static var previews: some View {
        LevelList()
    }
}
