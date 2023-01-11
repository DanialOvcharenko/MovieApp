//
//  SavedSeriesView.swift
//  MovieApp
//
//  Created by Mac on 02.01.2023.
//

import SwiftUI

struct SavedSeriesView: View {
    
    @StateObject var vm = CoreDataSerieViewModel()
    
    @State var selectedType: SelectedType
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                        ForEach(vm.savedEntities) { (serie) in
                            NavigationLink(destination: SavedSerieDeteilView(serie: serie), label: {
                                SavedSerieCell(savedEntity: serie)
                                })
                                .frame(height: UIScreen.main.bounds.size.height / 2.8)
                        }
                        .onDelete(perform: vm.deleteSerie)
                    
                
                }
                .listStyle(.inset)
                
            }
            .navigationTitle("Favourite series")
        }
    }
}

struct SavedSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedSeriesView(selectedType: .series)
                .padding(.vertical)
                .navigationBarHidden(true)
        }
    }
}




// MARK: - Saved serie cell

struct SavedSerieCell: View {
    
    var savedEntity: SerieEntity
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(savedEntity.posterImage ?? "")")){ image in
                    image
                        .resizable()
                        .frame(width: 170, height: 250, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(savedEntity.title ?? "no name")
                .fontWeight(.bold)
            
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
        .padding()
    }
}
