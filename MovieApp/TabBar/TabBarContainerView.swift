//
//  TabBarContainerView.swift
//  MovieApp
//
//  Created by Mac on 05.12.2022.
//

import SwiftUI

struct TabBarContainerView<Content:View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
//        ZStack(alignment: .bottom) {
//            content
//                .ignoresSafeArea()
//
//            TabBarView(tabs: tabs, selection: $selection)
//        }
        VStack(spacing: 0) {
            ZStack {
                content
            }
            TabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .main, .search, .myList, .myAccount
    ]
    
    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
