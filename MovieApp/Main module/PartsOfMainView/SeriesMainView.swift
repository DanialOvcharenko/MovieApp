//
//  SeriesMainView.swift
//  MovieApp
//
//  Created by Mac on 23.12.2022.
//

import SwiftUI

struct SeriesMainView: View {
    
    @State var popularSeries: [Serie] = []
    @State var topRatedSeries: [Serie] = []
    @State var airingTodaySeries: [Serie] = []
    @State var onTheAirSeries: [Serie] = []
    
    @StateObject private var api = serieApi()
    
    @State var selectedType: SelectedType
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                Text("Popular now")
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top){
                        ForEach(popularSeries, id: \.id) { (serie) in
                            NavigationLink(destination: DeteilView(serie: serie, selectedType: selectedType), label: {
                                PopularSerieCell(serie: serie)
                                })
                                .frame(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.height / 2.1)
                                .background(Color("MSCardBackground"))
                                .cornerRadius(20)
                        }
                    }
                }
                .onAppear {
                    api.getSerie(query: "https://api.themoviedb.org/3/tv/popular?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                        popularSeries = model.series
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
                        ForEach(topRatedSeries, id: \.id) { (serie) in
                            NavigationLink(destination: DeteilView(serie: serie, selectedType: selectedType), label: {
                                TopRatedSerieCell(serie: serie)
                                })
                                .frame(width: UIScreen.main.bounds.size.width / 2.5, height: UIScreen.main.bounds.size.height / 4)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .onAppear {
                    api.getSerie(query: "https://api.themoviedb.org/3/tv/top_rated?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                        topRatedSeries = model.series
                    }
                }
                .shadow(color: Color.gray, radius: 15)
            }
            .padding(.horizontal)
            
            
            VStack {
                Text("Airing today")
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top){
                        ForEach(airingTodaySeries, id: \.id) { (serie) in
                            NavigationLink(destination: DeteilView(serie: serie, selectedType: selectedType), label: {
                                AiringTodaySerieCell(serie: serie)
                                })
                                .frame(width: UIScreen.main.bounds.size.width / 1.7, height: UIScreen.main.bounds.size.height / 4.8)
                        }
                    }
                }
                .onAppear {
                    api.getSerie(query: "https://api.themoviedb.org/3/tv/airing_today?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                        airingTodaySeries = model.series
                    }
                }
                .shadow(color: Color.gray, radius: 15)
            }
            .padding(.horizontal)
           
            Spacer()
                .frame(height: 25)
            
            VStack {
                Text("On the air")
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top){
                        ForEach(onTheAirSeries, id: \.id) { (serie) in
                            NavigationLink(destination: DeteilView(serie: serie, selectedType: selectedType), label: {
                                OnTheAirSerieCell(serie: serie)
                                })
                                .frame(width: UIScreen.main.bounds.size.width / 1.3, height: UIScreen.main.bounds.size.height / 3.8)
                        }
                    }
                }
                .onAppear {
                    api.getSerie(query: "https://api.themoviedb.org/3/tv/on_the_air?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                        onTheAirSeries = model.series
                    }
                }
                .shadow(color: Color.gray, radius: 15)
            }
            .padding(.horizontal)
            
            
            VStack {
                Text("Collections")
                    .font(.system(size: 36))
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


struct SeriesMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SeriesMainView(selectedType: .series)
                .padding(.vertical)
                .navigationBarHidden(true)
        }
    }
}



// MARK: - Popular serie cell

struct PopularSerieCell: View {
    
    var serie: Serie
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.poster_path ?? "")")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, alignment: .center)
                } placeholder: {
                    ProgressView()
                }
            }
            
            
            Text(serie.name ?? "")
                .foregroundColor(.primary)
                .font(.system(size: 20.0))
                .fontWeight(.bold)
                .padding(.top, 10)
                .lineLimit(1)
            
        }
    }
}


// MARK: - Top Rated serie cell

struct TopRatedSerieCell: View {
    
    var serie: Serie
    
    var body: some View {
        VStack {
            ZStack{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.backdrop_path ?? "")")){ image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .blur(radius: 7)
                } placeholder: {
                    ProgressView()
                }
                
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.poster_path ?? "")")){ image in
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
            
            Text("Rating: \(serie.vote_average ?? 0)")
                .foregroundColor(.primary)
                .fontWeight(.bold)
        }
    }
}


// MARK: - Airing today serie cell

struct AiringTodaySerieCell: View {
    
    var serie: Serie
    
    var body: some View {
        VStack {
            ZStack{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(serie.backdrop_path ?? "")")){ image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(serie.name ?? "")
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .lineLimit(1)
        }
        
    }
}


// MARK: - On the air serie cell

struct OnTheAirSerieCell: View {
    
    var serie: Serie
    
    var body: some View {
        VStack {
            HStack {
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
                
                VStack{
                    Text("\(serie.original_name ?? "")")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Popularity:")
                        Text("\(serie.popularity ?? 0)")
                        Spacer()
                        Text("Release")
                        Text("\(serie.first_air_date ?? "")")
                        Spacer()
                        Text("Language: \(serie.original_language ?? "")")
                        Spacer()
                    }
                }
                .foregroundColor(.primary)
                
                Divider()
            }
        }
    }
}
