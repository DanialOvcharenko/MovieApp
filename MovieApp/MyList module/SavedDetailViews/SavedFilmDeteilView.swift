//
//  SavedFilmDeteilView.swift
//  MovieApp
//
//  Created by Mac on 03.01.2023.
//

import SwiftUI

struct SavedFilmDeteilView: View {
    
    @State var movie: FilmEntity!
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var movieId = 0
    @State var movieVideos: [Video] = []
    @StateObject var movieVideoapi = videoApi()
    
    @State var personsInFilm: [Person] = []
    @StateObject var movieCastapi = movieCastApi()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                
                Text("Original title: \(movie.originalTitle ?? "-title-")")
                    .fontWeight(.bold)
                
                ZStack{
                    ZStack{
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropImage ?? "")")){ image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .blur(radius: 7)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        ZStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterImage ?? "")")){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 220, alignment: .center)
                            } placeholder: {
                                ProgressView()
                            }
                            
                        }
                        .padding()
                    }
                }
                
                
                VStack{
                    Text("Overview")
                        .fontWeight(.bold)
                    Text(movie.overview ?? "")
                }
                .padding()
                
                
                VStack{
                    Text("Cast")
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(personsInFilm, id: \.id) { (person) in
                                NavigationLink(destination: DeteilView(person: person, selectedType: .persons), label: {
                                    PersonInFilmCell(person: person)
                                    })
                                
                                    .frame(width: UIScreen.main.bounds.size.width / 2.8, height: UIScreen.main.bounds.size.height / 4)
                                
                            }
                        }
                    }
                    .onAppear {
                        movieId = Int(movie.id)
                        movieCastapi.getMovieCast(query: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                            personsInFilm = model.cast
                        }
                    }
                    .padding()
                    
                }
                
                Divider()
                
                VStack {
                    
                    VStack {
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text("\(movie.votes) by \(movie.voteCount) voters")
                        }
                        Divider()
                        Text("Date of release: \(movie.releaseDate ?? "none")")
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Original language: \(movie.language ?? "none")")
                        Divider()
                        Text("Popularity: \(movie.popularity)")
                        
                    }
                    
                }
                
                Divider()
                
                VStack {
                    NavigationLink {
                        MovieRecomendations(id: Int(movie.id), selectedType: .filmes)
                    } label: {
                        Text("Show similar movies")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThickMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(colorScheme == .dark ? Color("MSCardBackground") : Color.red, lineWidth: 2)
                    )
                .shadow(color: colorScheme == .dark ? Color("MSCardBackground") : Color.red, radius: 10)
                }

                Divider()
                
                VStack {
                    
                    Text("Trailers:")
                        .foregroundColor(.primary)
                        .font(.system(size: 22.0))
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(movieVideos, id: \.id) { (video) in
                                
                                VideoMovieCell(video: video)
                                
                            }
                        }
                    }
                    .onAppear {
                        movieId = Int(movie.id)
                        movieVideoapi.getVideo(query: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                            movieVideos = model.videos
                        }
                    }
                }
                
            }
            .padding(.bottom)
            .navigationBarTitle(movie.title ?? "-title-", displayMode: .inline)
        }
        
    }
}

struct SavedFilmDeteilView_Previews: PreviewProvider {
    static var previews: some View {
        SavedFilmDeteilView()
    }
}



