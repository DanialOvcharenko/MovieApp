//
//  SavedSerieDeteilView.swift
//  MovieApp
//
//  Created by Mac on 05.01.2023.
//

import SwiftUI

struct SavedSerieDeteilView: View {
    
    @State var serie: SerieEntity!
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var serieId = 0
    @State var serieVideos: [Video] = []
    @StateObject var serieVideoapi = videoApi()
    
    @State var personsInSerie: [Person] = []
    @StateObject var serieCastapi = serieCastApi()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                
                Text("Original title: \(serie.originalTitle ?? "-title-")")
                    .fontWeight(.bold)
                
                ZStack{
                    ZStack{
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.backdropImage ?? "")")){ image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .blur(radius: 7)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        ZStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.posterImage ?? "")")){ image in
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
                        serieId = Int(serie.id)
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
                            Text("\(serie.votes) by \(serie.voteCount) voters")
                        }
                        Divider()
                        Text("Date of release: \(serie.releaseDate ?? "none")")
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Original language: \(serie.language ?? "none")")
                        Divider()
                        Text("Popularity: \(serie.popularity)")
                        
                    }
                    
                }
                
                Divider()
                
                VStack {
                    NavigationLink {
                        SerieRecomendations(id: Int(serie.id), selectedType: .series)
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
                            ForEach(serieVideos, id: \.id) { (video) in
                                
                                VideoMovieCell(video: video)
                                
                            }
                        }
                    }
                    .onAppear {
                        serieId = Int(serie.id)
                        serieVideoapi.getVideo(query: "https://api.themoviedb.org/3/tv/\(serieId)/videos?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                            serieVideos = model.videos
                        }
                    }
                }
                
            }
            .padding(.bottom)
            .navigationBarTitle(serie.title ?? "-title-", displayMode: .inline)
        }
    }
}

struct SavedSerieDeteilView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSerieDeteilView()
    }
}
