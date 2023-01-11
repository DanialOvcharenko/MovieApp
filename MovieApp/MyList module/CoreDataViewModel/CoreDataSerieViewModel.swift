//
//  CoreDataSerieViewModel.swift
//  MovieApp
//
//  Created by Mac on 05.01.2023.
//

import Foundation
import CoreData

class CoreDataSerieViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [SerieEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataContainerSerie")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchSeries()
    }
    
    
    
    func fetchSeries() {
        let request = NSFetchRequest<SerieEntity>(entityName: "SerieEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    
    func addSerie(title: String, language: String, votes: Double, voteCount: Int, poster: String, backdrop: String, originalTitle: String, overview: String, releaseDate: String, popularity: Double, id: Int) {
        
        let newSerie = SerieEntity(context: container.viewContext)
        newSerie.overview = overview
        newSerie.title = title
        newSerie.language = language
        newSerie.votes = votes
        newSerie.voteCount = Int16(voteCount)
        newSerie.posterImage = poster
        newSerie.backdropImage = backdrop
        newSerie.originalTitle = originalTitle
        newSerie.releaseDate = releaseDate
        newSerie.popularity = popularity
        newSerie.id = Int32(id)
        saveData()
    }
    
    
    func deleteSerie(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchSeries()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}
