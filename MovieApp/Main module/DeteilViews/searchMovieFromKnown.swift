//
//  searchMovieFromKnown.swift
//  MovieApp
//
//  Created by Mac on 26.12.2022.
//

import SwiftUI

struct searchMovieFromKnown: View {
    
    @State var searchedMovie: [Movie] = []
    
    @StateObject private var mApi = movieApi()
    
    @State private var movieQuerry = "https://api.themoviedb.org/3/trending/movie/week?api_key=d736bf662f23f773be5ced737935827d"
    
    var movieName = ""
    @State var changedText = ""
    
    let spaceChanger = "%20"
    let space = " "
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        VStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: twoColumnGrid) {
                        ForEach(searchedMovie, id: \.id) { (movie) in
                            NavigationLink(destination: DeteilView(movie: movie, selectedType: .filmes), label: {
                                SearchedMovieCell(movie: movie)
                            })
                                .frame(width: UIScreen.main.bounds.size.width / 2.25, height: UIScreen.main.bounds.size.height / 3.1)
                            
                        }
                    }
                }
                
            }
            .onAppear {
                for item in movieName {
                    if String(item) == space {
                        changedText += spaceChanger
                    } else {
                        changedText += String(item)
                    }
                }
                movieQuerry = "https://api.themoviedb.org/3/search/movie?api_key=d736bf662f23f773be5ced737935827d&language=en-US&query=\(changedText)"
                mApi.getMovie(query: movieQuerry) { model in
                    searchedMovie = model.movies
                }
            }
            .onDisappear {
                changedText = ""
            }
            .shadow(color: Color.gray, radius: 15)
        }
        .padding(.horizontal)
        .navigationBarTitle(movieName, displayMode: .inline)
    }
}

struct searchMovieFromKnown_Previews: PreviewProvider {
    static var previews: some View {
        searchMovieFromKnown()
    }
}
