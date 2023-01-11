//
//  CoreDataAccountViewModel.swift
//  MovieApp
//
//  Created by Mac on 09.01.2023.
//

import Foundation
import CoreData

class CoreDataAccountViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [GenreEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataContainerAccount")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchGenres()
    }
    
    
    
    func fetchGenres() {
        let request = NSFetchRequest<GenreEntity>(entityName: "GenreEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    
    func addGenre(genre: String) {
        
        let newGenre = GenreEntity(context: container.viewContext)
        newGenre.genre = genre
        saveData()
    }
    
    
    
    func deleteGenre(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchGenres()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}
