//
//  SearchView.swift
//  MovieApp
//
//  Created by Mac on 30.11.2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchedMovie: [Movie] = []
    @State var searchedSerie: [Serie] = []
    @State var searchedPerson: [Person] = []
    
    @StateObject private var mApi = movieApi()
    @StateObject private var sApi = serieApi()
    @StateObject private var pApi = personApi()
    
    @State private var movieQuerry = "https://api.themoviedb.org/3/trending/movie/week?api_key=d736bf662f23f773be5ced737935827d"
    @State private var serieQuerry = "https://api.themoviedb.org/3/tv/popular?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1"
    @State private var personQuerry = "https://api.themoviedb.org/3/trending/person/week?api_key=d736bf662f23f773be5ced737935827d"
    
    @State private var searchText = ""
    @State var changedText = ""
    let spaceChanger = "%20"
    let space = " "
    
    var arrayOfGenres: [String] = ["👊 boevik", "😂 comedy", "📑 documentary", "🧟‍♂️ fantasy", "🚌 adventure", "😱 triller", "🥰 romantic", "🕵️‍♀️ detectiv", "🤯 animation", "🇱🇷 vestern", "🥊 sport", "🔫 war"]
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("search", text: $searchText)
                        .padding(7)
                        .padding(.leading, 10)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                        )
                    Image(systemName: "xmark")
                        .onTapGesture {
                            searchText = ""
                            changedText = ""
                        }
                }
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        Text("Movies")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top){
                                ForEach(searchedMovie, id: \.id) { (movie) in
                                    NavigationLink(destination: DeteilView(movie: movie, selectedType: .filmes), label: {
                                        SearchedMovieCell(movie: movie)
                                        })
                                        .frame(width: UIScreen.main.bounds.size.width / 2.1, height: UIScreen.main.bounds.size.height / 2.9)
                                    
                                }
                            }
                        }
                        .onAppear {
                            mApi.getMovie(query: movieQuerry) { model in
                                searchedMovie = model.movies
                            }
                        }
                        .onChange(of: searchText) { value in
                            if value.last != " " {
                                changedText = value.replacingOccurrences(of: space, with: spaceChanger)
                            }
                            if value.isEmpty {
                                movieQuerry = "https://api.themoviedb.org/3/trending/movie/week?api_key=d736bf662f23f773be5ced737935827d"
                                mApi.getMovie(query: movieQuerry) { model in
                                    searchedMovie = model.movies
                                }
                            } else {
                                movieQuerry = "https://api.themoviedb.org/3/search/movie?api_key=d736bf662f23f773be5ced737935827d&language=en-US&query=\(changedText)"
                                mApi.getMovie(query: movieQuerry) { model in
                                    searchedMovie = model.movies
                                }
                            }
                        }
                        .shadow(color: Color.gray, radius: 15)
                    }
                    .padding(.horizontal)
                    
                    
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
                    
                    
                    Divider()
                    
                    VStack {
                        Text("Series")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top){
                                ForEach(searchedSerie, id: \.id) { (serie) in
                                    NavigationLink(destination: DeteilView(serie: serie, selectedType: .series), label: {
                                        SearchedSerieCell(serie: serie)
                                        })
                                        .frame(width: UIScreen.main.bounds.size.width / 2.1, height: UIScreen.main.bounds.size.height / 2.9)
                                }
                            }
                        }
                        .onAppear {
                            sApi.getSerie(query: serieQuerry) { model in
                                searchedSerie = model.series
                            }
                        }
                        .onChange(of: searchText) { value in
                            if value.last != " " {
                                changedText = value.replacingOccurrences(of: space, with: spaceChanger)
                            }
                            if value.isEmpty {
                                serieQuerry = "https://api.themoviedb.org/3/tv/popular?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1"
                                sApi.getSerie(query: serieQuerry) { model in
                                    searchedSerie = model.series
                                }
                            } else {
                                serieQuerry = "https://api.themoviedb.org/3/search/tv?api_key=d736bf662f23f773be5ced737935827d&language=en-US&query=\(changedText)"
                                sApi.getSerie(query: serieQuerry) { model in
                                    searchedSerie = model.series
                                }
                            }
                        }
                        .shadow(color: Color.gray, radius: 15)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    VStack {
                        Text("Persons")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top){
                                ForEach(searchedPerson, id: \.id) { (person) in
                                    NavigationLink(destination: DeteilView(person: person, selectedType: .persons), label: {
                                        SearchedPersonCell(person: person)
                                        })
                                        .frame(width: UIScreen.main.bounds.size.width / 2.1, height: UIScreen.main.bounds.size.height / 2.9)
                                }
                            }
                        }
                        .onAppear {
                            pApi.getPerson(query: personQuerry) { model in
                                searchedPerson = model.persons
                            }
                        }
                        .onChange(of: searchText) { value in
                            if value.last != " " {
                                changedText = value.replacingOccurrences(of: space, with: spaceChanger)
                            }
                            if value.isEmpty {
                                personQuerry = "https://api.themoviedb.org/3/trending/person/week?api_key=d736bf662f23f773be5ced737935827d"
                                pApi.getPerson(query: personQuerry) { model in
                                    searchedPerson = model.persons
                                }
                            } else {
                                personQuerry = "https://api.themoviedb.org/3/search/person?api_key=d736bf662f23f773be5ced737935827d&language=en-US&query=\(changedText)"
                                pApi.getPerson(query: personQuerry) { model in
                                    searchedPerson = model.persons
                                }
                            }
                        }
                        .shadow(color: Color.gray, radius: 15)
                    }
                    .padding(.horizontal)
                    
                }
                .ignoresSafeArea()
                
                Spacer()
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .padding(.vertical)
    }
}


// MARK: - Searched movie cell

struct SearchedMovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            VStack {
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
                
                Text(movie.title ?? "-title-")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
    }
}


// MARK: - Searched serie cell

struct SearchedSerieCell: View {
    
    var serie: Serie
    
    var body: some View {
        VStack {
            VStack {
                ZStack{
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.backdrop_path ?? "")")){ image in
                        image
                            .resizable()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .blur(radius: 6)
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack{
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.poster_path ?? "")")){ image in
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
                
                Text(serie.name ?? "-name-")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
    }
}


// MARK: - Searched person cell

struct SearchedPersonCell: View {
    
    var person: Person
    
    var body: some View {
        VStack {
            VStack {
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(person.profile_path ?? "")")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .cornerRadius(20)
                        .padding(.vertical)
                } placeholder: {
                    ProgressView()
                }
                
                Text(person.name ?? "-name-")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
    }
}


