//
//  DataBase.swift
//  ExpenseTrackApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit
import CoreData
class DataBase: NSObject {
    
    var managedObjectContext = NSManagedObjectContext()
    
    
    func createData(data:Expense)
    {
        
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
       
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let expenseEntity = NSEntityDescription.entity(forEntityName: "Expense", in: managedContext)!
        
        
    
        let expenseVar = NSManagedObject(entity: expenseEntity, insertInto: managedContext)
        expenseVar.setValue(data.title, forKeyPath: "title")
        expenseVar.setValue(data.amount, forKey: "amount")
        expenseVar.setValue(data.category, forKey: "category")
        expenseVar.setValue(data.date, forKey: "date")
        expenseVar.setValue(data.notes, forKey: "notes")

       
        
        do {
            try managedContext.save()
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    func retrieveData() -> [NSManagedObject] {
        
        
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
       
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        

        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            return result
           
            
        } catch {
            
            print("Failed")
            return []
        }
    }
    
    
    func retrieveDataByCategory(value:String) -> [NSManagedObject] {
        
        
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
           
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        
        fetchRequest.predicate = NSPredicate(format: "category = %@",value )
       

        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            return result
           
            
        } catch {
            
            print("Failed")
            return []
        }
    }
    
    func retrieveDataByDate(startDate:String,toDate:String) -> [NSManagedObject] {
        
        
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
           
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate, toDate)


        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            return result
           
            
        } catch {
            
            print("Failed")
            return []
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ExpenseTackerApp")
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

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
   
    
}
