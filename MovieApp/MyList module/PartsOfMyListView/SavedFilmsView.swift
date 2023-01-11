//
//  SavedFilmsView.swift
//  MovieApp
//
//  Created by Mac on 02.01.2023.
//

import SwiftUI
import CoreData

struct SavedFilmsView: View {
    
    @StateObject var vm = CoreDataFilmViewModel()
    
    @State var selectedType: SelectedType
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                        ForEach(vm.savedEntities) { (film) in
                            NavigationLink(destination: SavedFilmDeteilView(movie: film), label: {
                                SavedMovieCell(savedEntity: film)
                                })
                                .frame(height: UIScreen.main.bounds.size.height / 2.8)
                        }
                        .onDelete(perform: vm.deleteFilm)
                    
                
                }
                .listStyle(.inset)
                
            }
            .navigationTitle("Favourite films")
        }
    }
}

struct SavedFilmsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedFilmsView(selectedType: .filmes)
                .padding(.vertical)
                .navigationBarHidden(true)
        }
    }
}




// MARK: - Saved movie cell

struct SavedMovieCell: View {
    
    var savedEntity: FilmEntity
    
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





 
