//
//  AllFilmsOfPerson.swift
//  MovieApp
//
//  Created by Mac on 06.01.2023.
//

import SwiftUI

struct AllFilmsOfPerson: View {
    
    @State var filmsOfPerson: [Movie] = []
    
    @StateObject private var api = castApi()
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var id: Int
    @State var selectedType: SelectedType
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                
                if filmsOfPerson.isEmpty {
                    Text("Sorry, this person has not been in films")
                } else {
                    LazyVGrid(columns: twoColumnGrid) {
                        ForEach(filmsOfPerson, id: \.id) { (movie) in
                            NavigationLink(destination: DeteilView(movie: movie, selectedType: selectedType), label: {
                                PopularMovieCell(movie: movie)
                            })
                                .padding(.vertical, 10)
                                .frame(width: UIScreen.main.bounds.size.width / 2.2, height: UIScreen.main.bounds.size.height / 3)
                                .cornerRadius(20)
                        }
                    }
                }
                
            }
            .onAppear {
                api.getCast(query: "https://api.themoviedb.org/3/person/\(id)/movie_credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                    filmsOfPerson = model.cast
                }
            }
            .shadow(color: colorScheme == .dark ? Color.gray : Color.black, radius: 15)
        }
        .navigationBarTitle("Films")
    }
}

struct AllFilmsOfPerson_Previews: PreviewProvider {
    static var previews: some View {
        AllFilmsOfPerson(id: 2, selectedType: .filmes)
    }
}
