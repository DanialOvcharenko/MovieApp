//
//  filmDeteilView.swift
//  MovieApp
//
//  Created by Mac on 26.12.2022.
//

import SwiftUI

extension DeteilView {
    
    //MARK: - filmDeteilView
    var filmDeteilView: some View {
        VStack{
    
            Text("Original title: \(movie.original_title ?? "-title-")")
                .fontWeight(.bold)
    
            ZStack{
                ZStack{
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path ?? "")")){ image in
                        image
                            .resizable()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .blur(radius: 7)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    ZStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 220, alignment: .center)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        HStack{
                            Spacer()
                            VStack {
                                Spacer()
                                
                                ZStack{
                                    Button {
                                        
                                        if vmFilm.savedEntities.contains(where: { $0.title == movie.title } ) {
                                            alertTitle = "Attention"
                                            alertMessage = "this movie is already added"
                                            showingAlert = true
                                        } else {
                                            alertTitle = "Congratulations"
                                            alertMessage = "you add this movie"
                                            showingAlert = true
                                            vmFilm.addFilm(
                                                title: movie.title ?? "noTitle",
                                                language: movie.original_language ?? "noLanguage",
                                                votes: movie.vote_average ?? 0,
                                                voteCount: movie.vote_count ?? 0,
                                                poster: movie.poster_path ?? "",
                                                backdrop: movie.backdrop_path ?? "",
                                                originalTitle: movie.original_title ?? "",
                                                overview: movie.overview ?? "",
                                                releaseDate: movie.release_date ?? "",
                                                popularity: movie.popularity ?? 0,
                                                id: movie.id ?? 0
                                            )
                                        }
                                        
                                        
                                    } label: {
                                        Circle()
                                            .frame(width: 50, height: 50)
                                    }
                                    .foregroundColor(Color.red)
                                    .alert(isPresented:$showingAlert) {
                                        Alert(
                                            title: Text(alertTitle),
                                            message: Text(alertMessage),
                                            dismissButton: .default(Text("OK"))
                                        )
                                    }
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 30))
                                        .foregroundColor(.primary)
                                        .frame(width: 40, height: 40)
                                }
                                
                                Spacer()
                                    .frame(height: 10)
                            }
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
                    movieId = movie.id ?? 0
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
                        Text("\(movie.vote_average ?? 0) by \(movie.vote_count ?? 0) voters")
                    }
                    Divider()
                    Text("Date of release: \(movie.release_date ?? "none")")
                    
                }
                
                Divider()
                
                HStack {
                    Text("Original language: \(movie.original_language ?? "none")")
                    Divider()
                    Text("Popularity: \(movie.popularity ?? 0)")
                    
                }
                
            }
            
            Divider()
            
            VStack {
                NavigationLink {
                    MovieRecomendations(id: movie.id ?? 2, selectedType: .filmes)
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
                        .stroke(colorSchemeFilm == .dark ? Color("MSCardBackground") : Color.red, lineWidth: 2)
                )
            .shadow(color: colorSchemeFilm == .dark ? Color("MSCardBackground") : Color.red, radius: 10)
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
                    movieId = movie.id ?? 0
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


// MARK: - Video movie cell

struct VideoMovieCell: View {
    
    var video: Video
    
    var body: some View {
        VStack {
            
            Link(destination: URL(string: "https://www.youtube.com/watch?v=\(video.key ?? "nFet6yCeOPk"))")!) {
                
                HStack {
                    ZStack{
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.red)
                        
                        Image(systemName: "video.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.primary)
                            .frame(width: 40, height: 40)
                    }
                    VStack(alignment: .center) {
                        Text(video.name ?? "")
                            .foregroundColor(.primary)
                            .font(.system(size: 20.0))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        HStack {
                            Text(video.site ?? "")
                                .foregroundColor(.red)
                            
                            Text(video.published_at ?? "")
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.leading)
                    }
                }
                .padding(.horizontal)
            }
            
            Divider()
        }
    }
}




// MARK: - Person in film cell

struct PersonInFilmCell: View {
    
    var person: Person
    
    var body: some View {
        
        VStack{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(person.profile_path ?? "")")){ image in
                image
                    .resizable()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
            Text(person.name ?? "")
                .foregroundColor(.primary)
                .lineLimit(1)
        }
    }
    
}
