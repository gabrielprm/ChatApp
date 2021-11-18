//
//  CoreDataManager.swift
//  Mapp
//
//  Created by Pedro Ésli Vieira do Nascimento on 18/11/21.
//

//import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    private init(){ }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Mapp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    @discardableResult func createCDAnnotation(title: String, latitude: Double, longitude: Double) -> CDAnnotation{
        let newCDAnnotation = CDAnnotation(context: self.context)
        newCDAnnotation.tittle = title
        newCDAnnotation.latitude = latitude
        newCDAnnotation.longitude = longitude
        
        saveContext()
        return newCDAnnotation
    }
    
    func fetchAllCDAnnotations() -> [CDAnnotation] {
        do {
            let result = try self.context.fetch(CDAnnotation.fetchRequest())
            return result
        }
        catch{
            print("Error trying to fetch all CDAnnotations: " + error.localizedDescription)
            return []
        }
    }
    
    func fetchCDAnnotation(latitude: Double, longitude: Double) -> CDAnnotation? {
        let fetchRequest = CDAnnotation.fetchRequest()
        let predicate = NSPredicate(format: "latitude == %d AND longitude == %d", latitude, longitude)
        fetchRequest.predicate = predicate
        
        do{
            let result = try self.context.fetch(fetchRequest)
            return result.first
        }
        catch{
            print("Error trying to fetch a CDAnnotation: " + error.localizedDescription)
            return nil
        }
    }
}
