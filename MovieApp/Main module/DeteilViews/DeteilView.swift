//
//  FilmDeteilView.swift
//  MovieApp
//
//  Created by Mac on 23.12.2022.
//

import SwiftUI

struct DeteilView: View {
    
    @State var movie: Movie!
    @State var serie: Serie!
    @State var person: Person!
    
    @State var gender = ""
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.colorScheme) var colorSchemeFilm
    
    @State var knownFor: [KnownFor] = []
    
    @State var selectedType: SelectedType
    
    @State var movieId = 0
    @State var movieVideos: [Video] = []
    @StateObject var movieVideoapi = videoApi()
    
    @State var serieId = 0
    @State var serieVideos: [serieVideo] = []
    @StateObject var serieVideoapi = videoSerieApi()
    
    @StateObject var vmFilm = CoreDataFilmViewModel()
    @StateObject var vmSerie = CoreDataSerieViewModel()
    @StateObject var vmPerson = CoreDataPersonViewModel()
    
    @State var personsInFilm: [Person] = []
    @StateObject var movieCastapi = movieCastApi()
    
    @State var personsInSerie: [Person] = []
    @StateObject var serieCastapi = serieCastApi()
    
    @State var personImages: [Images] = []
    @StateObject var personImageapi = personImageApi()
    
    @State var showingAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            if selectedType.rawValue == "Filmes" {
                filmDeteilView
            } else if selectedType.rawValue == "Series" {
                serieDeteilView
            } else if selectedType.rawValue == "Persons" {
                personDeteilView
            }
            
        }
    }
}

struct DeteilView_Previews: PreviewProvider {
    static var previews: some View {
        DeteilView(selectedType: .filmes)
    }
}






