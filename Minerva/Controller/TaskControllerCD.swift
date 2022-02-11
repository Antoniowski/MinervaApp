//
//  TaskControllerCD.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import Foundation
import CoreData

class TaskControllerCD{
    let dataContainer: NSPersistentContainer
    
    init(){
        dataContainer = NSPersistentContainer(name: "TaskModelCD")
        dataContainer.loadPersistentStores{(description, error) in
            if let error = error {
                fatalError("CORE DATA ERROR: \(error)")
            }
        }
    }
    
    func AddTask(title: String, description: String, priority: PriorityLevel, completed: Bool = false){
        let task = TaskCD(context: dataContainer.viewContext)
        task.title = title
        task.activity_description = description
        task.priority = priority.rawValue
        
        do{
            try dataContainer.viewContext.save()
        }catch{
            print("Failed save")
        }
    }
    
    func DeleteTask(task: TaskCD){
        dataContainer.viewContext.delete(task)
        do{
            try dataContainer.viewContext.save()
        }catch{
            dataContainer.viewContext.rollback()
            print("Delete Failed")
        }
    }
    
    func GetAllTask()->[TaskCD]{
        let fetchRequest: NSFetchRequest<TaskCD> = TaskCD.fetchRequest()
        do{
            return try dataContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
}
