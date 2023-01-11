//
//  CoreDataPersonViewModel.swift
//  MovieApp
//
//  Created by Mac on 05.01.2023.
//

import Foundation
import CoreData

class CoreDataPersonViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [PersonEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataContainerPerson")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchPersons()
    }
    
    
    
    func fetchPersons() {
        let request = NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    
    func addPerson(name: String, image: String, status: String, popularity: Double, gender: Int, id: Int) {
        
        let newPerson = PersonEntity(context: container.viewContext)
        newPerson.name = name
        newPerson.image = image
        newPerson.status = status
        newPerson.popularity = popularity
        newPerson.gender = Int32(gender)
        newPerson.id = Int32(id)
        saveData()
    }
    
    
    func deletePerson(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchPersons()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}
