//
//  MyListView.swift
//  MovieApp
//
//  Created by Mac on 30.11.2022.
//

import SwiftUI

struct MyListView: View {
    
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
                
                SavedChosenTypeView(selectedType: selectedType)
                    
                
                Spacer()
            }
            
            .navigationBarHidden(true)
        }
    }
}


struct SavedChosenTypeView: View {
    
    var selectedType: SelectedType
    
    var body: some View {
        switch selectedType {
        case .filmes:
            
            SavedFilmsView(selectedType: selectedType)
            
        case .series:
            
            SavedSeriesView(selectedType: selectedType)
            
        case .persons:
            
            SavedPersonsView(selectedType: selectedType)
            
        }
    }
}


struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}



