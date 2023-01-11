//
//  CoreDataNameViewModel.swift
//  MovieApp
//
//  Created by Mac on 11.01.2023.
//

import Foundation
import CoreData

class CoreDataNameViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [NameEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataContainerName")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchNames()
    }
    
    
    
    func fetchNames() {
        let request = NSFetchRequest<NameEntity>(entityName: "NameEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    
    func addName(name: String, surname: String, age: Int32) {
        
        let newName = NameEntity(context: container.viewContext)
        newName.name = name
        newName.surname = surname
        newName.age = age
        saveData()
    }
    
    
    func deleteName() {
        let entity = savedEntities[0]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func deleteForSecond(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchNames()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}
