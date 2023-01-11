//
//  TabBarItem.swift
//  MovieApp
//
//  Created by Mac on 05.12.2022.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case main, search, myList, myAccount
    
    var iconName: String {
        switch self {
        case .main: return "film"
        case .search: return "magnifyingglass"
        case .myList: return "tray.full"
        case .myAccount: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .main: return "Main"
        case .search: return "Search"
        case .myList: return "My list"
        case .myAccount: return "My account"
        }
    }
    
    var color: Color {
        switch self {
        case .main: return Color.red
        case .search: return Color.red
        case .myList: return Color.red
        case .myAccount: return Color.red
        }
    }
    
}

