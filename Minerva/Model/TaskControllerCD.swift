//
//  TaskControllerCD.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import Foundation
import CoreData
import Combine

struct TaskControllerCD{
    
    static let shared = TaskControllerCD()
    static var preview: TaskControllerCD = {
        let result = TaskControllerCD(inMemory: true)
        let viewContext = result.dataContainer.viewContext
        return result
    }()
    
    let dataContainer: NSPersistentContainer
    
    init(inMemory: Bool = false){
        dataContainer = NSPersistentContainer(name: "TaskModelCD")
        if inMemory{
            dataContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        dataContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        dataContainer.loadPersistentStores{(description, error) in
            if let error = error {
                fatalError("CORE DATA ERROR: \(error)")
            }
        }
    }
    
    func SaveContext(completionHandler: @escaping (Error?) -> Void){
        if TaskControllerCD.shared.dataContainer.viewContext.hasChanges{
            do{
                try TaskControllerCD.shared.dataContainer.viewContext.save()
                completionHandler(nil)
            }catch{
                completionHandler(error)
            }
        }
    }
}
