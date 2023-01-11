//
//  MoviRecomendations.swift
//  MovieApp
//
//  Created by Mac on 08.01.2023.
//

import SwiftUI

struct MovieRecomendations: View {
    
    @State var movieRecomendations: [Movie] = []
    
    @StateObject private var api = movieRecomendationsApi()
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var id: Int
    @State var selectedType: SelectedType
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                
                if movieRecomendations.isEmpty {
                    Text("Sorry, we don't have recomendations for this movie")
                } else {
                    LazyVGrid(columns: twoColumnGrid) {
                        ForEach(movieRecomendations, id: \.id) { (movie) in
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
                api.getMovieRecomendations(query: "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                    movieRecomendations = model.results
                }
            }
            .shadow(color: colorScheme == .dark ? Color.gray : Color.black, radius: 15)
        }
        .navigationBarTitle("Film recomendations")
    }
}

struct MovieRecomendations_Previews: PreviewProvider {
    static var previews: some View {
        MovieRecomendations(id: 2, selectedType: .filmes)
    }
}


