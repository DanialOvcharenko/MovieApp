//
//  AllSeriesOfPerson.swift
//  MovieApp
//
//  Created by Mac on 07.01.2023.
//

import SwiftUI

struct AllSeriesOfPerson: View {
    
    @State var seriesOfPerson: [Serie] = []
    
    @StateObject private var api = castSApi()
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var id: Int
    @State var selectedType: SelectedType
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                
                if seriesOfPerson.isEmpty {
                    Text("Sorry, this person has not been in series")
                } else {
                    LazyVGrid(columns: twoColumnGrid) {
                        ForEach(seriesOfPerson, id: \.id) { (serie) in
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
                api.getCast(query: "https://api.themoviedb.org/3/person/\(id)/tv_credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US") { model in
                    seriesOfPerson = model.cast
                }
            }
            .shadow(color: colorScheme == .dark ? Color.gray : Color.black, radius: 15)
        }
        .navigationBarTitle("Series")
    }
}

struct AllSeriesOfPerson_Previews: PreviewProvider {
    static var previews: some View {
        AllSeriesOfPerson(id: 2, selectedType: .series)
    }
}
