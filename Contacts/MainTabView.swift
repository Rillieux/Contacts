//
//  MainTabView.swift
//  Contacts
//
//  Created by Dave Kondris on 14/02/21.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContactList()
                .tabItem{
                    VStack{
                        Image(systemName: "person.crop.circle.fill")
                        Text("Contacts")
                    }
                }.tag(1)
            CategoryList()
                .tabItem{
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("Categories")
                    }
                }.tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
