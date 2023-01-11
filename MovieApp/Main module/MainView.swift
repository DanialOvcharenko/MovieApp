//
//  MainView.swift
//  MovieApp
//
//  Created by Mac on 30.11.2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @State private var selectedType: SelectedType = .filmes
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack{
                    Picker("Choose a type", selection: $selectedType) {
                        ForEach(SelectedType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top)
                    .padding(.horizontal)
                }
                
                ChosenTypeView(selectedType: selectedType)
                    
                
                Spacer()
            }
            //.background(Color.blue) // для цвета общей темы, но надо добавить и к таб бару в КонтентВью и на остальных Вью
            
            .navigationBarHidden(true)
        }
    }
}


enum SelectedType: String, CaseIterable {
    case filmes = "Filmes"
    case series = "Series"
    case persons = "Persons"
}


struct ChosenTypeView: View {
    
    var selectedType: SelectedType
    
    var body: some View {
        switch selectedType {
        case .filmes:
            
            FilmsMainView(selectedType: selectedType)
            
        case .series:
            
            SeriesMainView(selectedType: selectedType)
            
        case .persons:
            
            PersonsMainView(selectedType: selectedType)
            
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
