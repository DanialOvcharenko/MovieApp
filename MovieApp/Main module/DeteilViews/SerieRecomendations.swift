//
//  SerieRecomendations.swift
//  MovieApp
//
//  Created by Mac on 08.01.2023.
//

import SwiftUI

struct SerieRecomendations: View {
    
    @State var serieRecomendations: [Serie] = []
    
    @StateObject private var api = serieRecomendationsApi()
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var id: Int
    @State var selectedType: SelectedType
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                
                if serieRecomendations.isEmpty {
                    Text("Sorry, we don't have recomendations for this serie")
                } else {
                    LazyVGrid(columns: twoColumnGrid) {
                        ForEach(serieRecomendations, id: \.id) { (serie) in
                            NavigationLink(destination: DeteilView(serie: serie, selectedType: selectedType), label: {
                                PopularSerieCell(serie: serie)
                            })
                                .padding(.vertical, 10)
                                .frame(width: UIScreen.main.bounds.size.width / 2.2, height: UIScreen.main.bounds.size.height / 3)
                                .cornerRadius(20)
                        }
                    }
                }
                
            }
            .onAppear {
                api.getSerieRecomendations(query: "https://api.themoviedb.org/3/tv/\(id)/recommendations?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                    serieRecomendations = model.results
                }
            }
            .shadow(color: colorScheme == .dark ? Color.gray : Color.black, radius: 15)
        }
        .navigationBarTitle("Film recomendations")
    }
}

struct SerieRecomendations_Previews: PreviewProvider {
    static var previews: some View {
        MovieRecomendations(id: 2, selectedType: .filmes)
    }
}
