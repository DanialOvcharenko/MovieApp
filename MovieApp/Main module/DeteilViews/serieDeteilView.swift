//
//  serieDeteilView.swift
//  MovieApp
//
//  Created by Mac on 26.12.2022.
//

import SwiftUI

extension DeteilView {
    
    //MARK: - serieDeteilView
    var serieDeteilView: some View {
        
        VStack{
    
            Text("Original name: \(serie.original_name ?? "-name-")")
                .fontWeight(.bold)
    
            ZStack{
                ZStack{
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.backdrop_path ?? "")")){ image in
                        image
                            .resizable()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .blur(radius: 7)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    ZStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.poster_path ?? "")")){ image in
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
                                        
                                        if vmSerie.savedEntities.contains(where: { $0.title == serie.name } ) {
                                            alertTitle = "Attention"
                                            alertMessage = "this serie is already added"
                                            showingAlert = true
                                        } else {
                                            alertTitle = "Congratulations"
                                            alertMessage = "you add this serie"
                                            showingAlert = true
                                            vmSerie.addSerie(
                                                title: serie.name ?? "noTitle",
                                                language: serie.original_language ?? "noLanguage",
                                                votes: serie.vote_average ?? 0,
                                                voteCount: serie.vote_count ?? 0,
                                                poster: serie.poster_path ?? "",
                                                backdrop: serie.backdrop_path ?? "",
                                                originalTitle: serie.original_name ?? "",
                                                overview: serie.overview ?? "",
                                                releaseDate: serie.first_air_date ?? "",
                                                popularity: serie.popularity ?? 0,
                                                id: serie.id ?? 0
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
                Text(serie.overview ?? "")
            }
            .padding()
            
            VStack{
                Text("Cast")
                    .fontWeight(.bold)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top){
                        ForEach(personsInSerie, id: \.id) { (person) in
                            NavigationLink(destination: DeteilView(person: person, selectedType: .persons), label: {
                                PersonInSerieCell(person: person)
                                })
                            
                                .frame(width: UIScreen.main.bounds.size.width / 2.8, height: UIScreen.main.bounds.size.height / 4)
                            
                        }
                    }
                }
                .onAppear {
                    serieId = serie.id ?? 0
                    serieCastapi.getSerieCast(query: "https://api.themoviedb.org/3/tv/\(serieId)/credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                        personsInSerie = model.cast
                    }
                }
                .padding()
                
            }
            
            Divider()
            
            VStack {
                
                VStack {
                    HStack {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("\(serie.vote_average ?? 0) by \(serie.vote_count ?? 0) voters")
                    }
                    Divider()
                    Text("Date of release: \(serie.first_air_date ?? "none")")
                    
                }
                
                Divider()
                
                HStack {
                    Text("Original language: \(serie.original_language ?? "none")")
                    Divider()
                    Text("Popularity: \(serie.popularity ?? 0)")
                    
                }
                
            }
            
            Divider()
            
            VStack {
                NavigationLink {
                    SerieRecomendations(id: serie.id ?? 2, selectedType: .series)
                } label: {
                    Text("Show similar series")
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
                    if serieVideos.isEmpty {
                        Text("sorry we don't have a trailers")
                    } else {
                        VStack {
                            ForEach(serieVideos, id: \.id) { (video) in
                                
                                VideoSerieCell(video: video)
                                
                            }
                        }
                    }
                }
                .onAppear {
                    serieId = serie.id ?? 0
                    serieVideoapi.getSerieVideo(query: "https://api.themoviedb.org/3/tv/\(serieId)/videos?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                        serieVideos = model.videos
                    }
                }
            }
            
            
        }
        .padding(.bottom)
        .navigationBarTitle(serie.name ?? "-name-", displayMode: .inline)
    }
    
}


// MARK: - Popular serie cell

struct VideoSerieCell: View {
    
    var video: serieVideo
    
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



// MARK: - Person in serie cell

struct PersonInSerieCell: View {
    
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
