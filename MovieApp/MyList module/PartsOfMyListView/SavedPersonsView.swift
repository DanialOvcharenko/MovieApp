//
//  SavedPersonsView.swift
//  MovieApp
//
//  Created by Mac on 02.01.2023.
//

import SwiftUI

struct SavedPersonsView: View {
    
    @StateObject var vm = CoreDataPersonViewModel()
    
    @State var selectedType: SelectedType
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(vm.savedEntities) { (person) in
                        NavigationLink(destination: SavedPersonsDeteilView(person: person), label: {
                            SavedPersonCell(savedEntity: person)
                        })
                            .frame(height: UIScreen.main.bounds.size.height / 2.8)
                    }
                    .onDelete(perform: vm.deletePerson)
                    
                    
                }
                .listStyle(.inset)
            }
            .navigationTitle("Favourite persons")
            
        }
    }


struct SavedPersonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedSeriesView(selectedType: .persons)
                .padding(.vertical)
                .navigationBarHidden(true)
        }
    }
}


    // MARK: - Saved person cell

    struct SavedPersonCell: View {
        
        var savedEntity: PersonEntity
        
        var body: some View {
            VStack(alignment: .center) {
                ZStack{
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(savedEntity.image ?? "")")){ image in
                        image
                            .resizable()
                            .frame(width: 170, height: 250, alignment: .center)
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(savedEntity.name ?? "no name")
                    .fontWeight(.bold)
                
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding()
        }
    }
}
