//
//  CoreDataViewModel.swift
//  MovieApp
//
//  Created by Mac on 02.01.2023.
//

import Foundation
import CoreData

class CoreDataFilmViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FilmEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataContainerFilm")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchFilms()
    }
    
    
    
    func fetchFilms() {
        let request = NSFetchRequest<FilmEntity>(entityName: "FilmEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    
    func addFilm(title: String, language: String, votes: Double, voteCount: Int, poster: String, backdrop: String, originalTitle: String, overview: String, releaseDate: String, popularity: Double, id: Int) {
        
        let newFilm = FilmEntity(context: container.viewContext)
        newFilm.overview = overview
        newFilm.title = title
        newFilm.language = language
        newFilm.votes = votes
        newFilm.voteCount = Int16(voteCount)
        newFilm.posterImage = poster
        newFilm.backdropImage = backdrop
        newFilm.originalTitle = originalTitle
        newFilm.releaseDate = releaseDate
        newFilm.popularity = popularity
        newFilm.id = Int32(id)
        saveData()
    }
    
//    func updateFilm(entity: FilmEntity) {
//        let currentTitle = entity.title ?? ""
//        let newTitle = currentTitle + "!"
//        entity.title = newTitle
//        saveData()
//    }
    
    func deleteFilm(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFilms()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}
