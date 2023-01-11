//
//  ContentView.swift
//  MovieApp
//
//  Created by Mac on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedView: String = "film"
    @State private var tabSelection: TabBarItem = .main
    
    var body: some View {
        TabBarContainerView(selection: $tabSelection) {
            MainView()
                .tabBarItem(tab: .main, selection: $tabSelection)
            
            SearchView()
                .tabBarItem(tab: .search, selection: $tabSelection)
            
            MyListView()
                .tabBarItem(tab: .myList, selection: $tabSelection)
            
            MyAccountView()
                .tabBarItem(tab: .myAccount, selection: $tabSelection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ContentView()
            .preferredColorScheme(.dark)
    }
}


extension ContentView {
    
    private var defaultTabView: some View {
        TabView (selection: $selectedView) {
            
            MainView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Main")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            MyListView()
                .tabItem {
                    Image(systemName: "tray.full")
                    Text("My List")
                }
            
            MyAccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My account")
                } 
        
        }
    }
    
}
