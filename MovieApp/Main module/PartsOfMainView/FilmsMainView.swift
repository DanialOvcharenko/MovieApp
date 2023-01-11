//
//  FilmMainView.swift
//  MovieApp
//
//  Created by Mac on 23.12.2022.
//

import SwiftUI

struct FilmsMainView: View {
    
    @State var popularMovies: [Movie] = []
    @State var topRatedMovies: [Movie] = []
    @State var upcomingMovies: [Movie] = []
    @State var nowPlayingMovies: [Movie] = []
    
    @StateObject private var api = movieApi()
    
    @State var selectedType: SelectedType
    
    var arrayOfGenres: [String] = ["👊 boevik", "😂 comedy", "📑 documentary", "🧟‍♂️ fantasy", "🚌 adventure", "😱 triller", "🥰 romantic", "🕵️‍♀️ detectiv", "🤯 animation", "🇱🇷 vestern", "🥊 sport", "🔫 war"]
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    Text("Popular now")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(popularMovies, id: \.id) { (movie) in
                                NavigationLink(destination: DeteilView(movie: movie, selectedType: selectedType), label: {
                                    PopularMovieCell(movie: movie)
                                    })
                                    .frame(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.height / 2.1)
                                    .background(Color("MSCardBackground"))
                                    .cornerRadius(20)
                                
                            }
                        }
                    }
                    .onAppear {
                        api.getMovie(query: "https://api.themoviedb.org/3/trending/movie/week?api_key=d736bf662f23f773be5ced737935827d") { model in
                            popularMovies = model.movies
                        }
                    }
                    .shadow(color: Color.gray, radius: 15)
                }
                .padding(.horizontal)
                
                VStack {
                    Text("Top Rated")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(topRatedMovies, id: \.id) { (movie) in
                                NavigationLink(destination: DeteilView(movie: movie, selectedType: selectedType), label: {
                                    TopRatedMovieCell(movie: movie)
                                    })
                                    .frame(width: UIScreen.main.bounds.size.width / 2.5, height: UIScreen.main.bounds.size.height / 4)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .onAppear {
                        api.getMovie(query: "https://api.themoviedb.org/3/movie/top_rated?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                            topRatedMovies = model.movies
                        }
                    }
                    .shadow(color: Color.gray, radius: 15)
                }
                .padding(.horizontal)
                
                VStack {
                    Text("Upcoming")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(upcomingMovies, id: \.id) { (movie) in
                                NavigationLink(destination: DeteilView(movie: movie, selectedType: selectedType), label: {
                                    UpcomingMovieCell(movie: movie)
                                    })
                                    .frame(width: UIScreen.main.bounds.size.width / 1.7, height: UIScreen.main.bounds.size.height / 4.8)
                            }
                        }
                    }
                    .onAppear {
                        api.getMovie(query: "https://api.themoviedb.org/3/movie/upcoming?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                            upcomingMovies = model.movies
                        }
                    }
                    .shadow(color: Color.gray, radius: 15)
                }
                .padding(.horizontal)
                
                Spacer()
                    .frame(height: 25)
                
                VStack {
                    Text("Now Playing")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(nowPlayingMovies, id: \.id) { (movie) in
                                NavigationLink(destination: DeteilView(movie: movie, selectedType: selectedType), label: {
                                    NowPlayingMovieCell(movie: movie)
                                    })
                                    .frame(width: UIScreen.main.bounds.size.width / 1.3, height: UIScreen.main.bounds.size.height / 3.8)
                            }
                        }
                    }
                    .onAppear {
                        api.getMovie(query: "https://api.themoviedb.org/3/movie/now_playing?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                            nowPlayingMovies = model.movies
                        }
                    }
                    .shadow(color: Color.gray, radius: 15)
                }
                .padding(.horizontal)
                
                Spacer()
                    .frame(height: 25)
                
                VStack {
                    Text("Genres")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: twoColumnGrid) {
                            ForEach(arrayOfGenres, id: \.self) { genre in
                                Text("\(genre)")
                                    .padding(7)
                                    .font(.title2)
                                    .background(Color("MSCardBackground"))
                                        .cornerRadius(15)
                                    .padding(.vertical, 25)
                                    .onTapGesture {
                                        print("\(genre)")
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                
                VStack {
                    Text("Soon in cinemas")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("...")
                        .font(.system(size: 50))
                    
                }
                .padding(.horizontal)
                
                VStack {
                    Text("Collections")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("...")
                        .font(.system(size: 50))
                    
                }
                .padding(.horizontal)
                
            }
            .ignoresSafeArea()
        
        
    }
}

struct FilmMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilmsMainView(selectedType: .filmes)
                .padding(.vertical)
                .navigationBarHidden(true)
        }
    }
}



// MARK: - Popular movie cell

struct PopularMovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, alignment: .center)
                } placeholder: {
                    ProgressView()
                }
            }
            
            
            Text(movie.title ?? "")
                .foregroundColor(.primary)
                .font(.system(size: 20.0))
                .fontWeight(.bold)
                .padding(.top, 10)
                .lineLimit(1)
            
        }
    }
}


// MARK: - Top Rated movie cell

struct TopRatedMovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            ZStack{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path ?? "")")){ image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .blur(radius: 7)
                } placeholder: {
                    ProgressView()
                }
                
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")){ image in
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
            Spacer()
                .frame(height: 10)
            
            Text("Rating: \(movie.vote_average ?? 0)")
                .foregroundColor(.primary)
                .fontWeight(.bold)
        }
    }
}


// MARK: - Upcoming movie cell

struct UpcomingMovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            ZStack{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path ?? "")")){ image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(movie.title ?? "")
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .lineLimit(1)
        }
        
    }
}


// MARK: - Now Playing movie cell

struct NowPlayingMovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path ?? "")")){ image in
                        image
                            .resizable()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .blur(radius: 6)
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack{
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .cornerRadius(20)
                                .padding(.vertical)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                
                VStack{
                    Text("\(movie.original_title ?? "")")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Popularity:")
                        Text("\(movie.popularity ?? 0)")
                        Spacer()
                        Text("Release")
                        Text("\(movie.release_date ?? "")")
                        Spacer()
                        Text("Language: \(movie.original_language ?? "")")
                        Spacer()
                    }
                }
                .foregroundColor(.primary)
                
                Divider()
            }
        }
    }
}
