//
//  TaskControllerCD.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import Foundation
import CoreData

class TaskControllerCD: ObservableObject{
    let dataContainer: NSPersistentContainer
    
    init(){
        dataContainer = NSPersistentContainer(name: "TaskModelCD")
        dataContainer.loadPersistentStores{(description, error) in
            if let error = error {
                fatalError("CORE DATA ERROR: \(error)")
            }
        }
    }
    //ADD FUNC
    func AddTask(title: String, description: String, priority: PriorityLevel, completed: Bool = false, date: Date){
        let task = TaskCD(context: dataContainer.viewContext)
        task.title = title
        task.activity_description = description
        task.priority = priority.rawValue
        task.date_of_activity = date
        
        do{
            try dataContainer.viewContext.save()
        }catch{
            print("Failed save")
        }
    }
    
    func AddStatusBool(){
        let statusBool = AppStatusInfo(context: dataContainer.viewContext)
        
    newUserControll:
        if GetAppInfo().isEmpty == false{
            break newUserControll
        }else{
            statusBool.newUser = true
            
            do{
                try dataContainer.viewContext.save()
            }catch{
                print("Add Status Bool Failed")
            }
            
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
    
    
    //    UPDATE FUNCTIONS
    
    
    func UpdateTask(task: TaskCD, isCompleted: Bool){
        task.completed = isCompleted
        do{
            try dataContainer.viewContext.save()
        }catch{
            dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    
    func UpdateTask(task: TaskCD, title: String){
        task.title = title
        do{
            try dataContainer.viewContext.save()
        }catch{
            dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    func UpdateTask(task: TaskCD, desc: String){
        task.activity_description = desc
        do{
            try dataContainer.viewContext.save()
        }catch{
            dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    func UpdateTask(task: TaskCD, date: Date){
        task.date_of_activity = date
        do{
            try dataContainer.viewContext.save()
        }catch{
            dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    
    func UpdateTask(task: TaskCD, priority: PriorityLevel){
        task.priority = priority.rawValue
        do{
            try dataContainer.viewContext.save()
        }catch{
            dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    
    func SetFalseNewUser(user: AppStatusInfo){
        user.newUser = false
    }
    
    //    GET FUNC
    func GetAllTask()->[TaskCD]{
        let fetchRequest: NSFetchRequest<TaskCD> = TaskCD.fetchRequest()
        do{
            return try dataContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    
    func GetAllTaskOrdered()->[TaskCD]{
        let array = GetAllTask()
        var arrayLow: [TaskCD] = []
        var arrayMid: [TaskCD] = []
        var arrayHigh: [TaskCD] = []
        
        if array.isEmpty{
            return []
        }else{
            for T in array{
                switch(T.priority){
                case "a": arrayLow.append(T)
                case "b": arrayMid.append(T)
                case "c": arrayHigh.append(T)
                default: print("ciao")
                }
            }
            return arrayHigh+arrayMid+arrayLow
        }
    }
    
    //recupera il vettore dei bool
    func GetAppInfo()->[AppStatusInfo]{
        let fetchRequest: NSFetchRequest<AppStatusInfo> = AppStatusInfo.fetchRequest()
        do{
            return try dataContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func GetNewUserStatus()->Bool{
        let fetchRequest: NSFetchRequest<AppStatusInfo> = AppStatusInfo.fetchRequest()
        do{
            return try dataContainer.viewContext.fetch(fetchRequest)[0].newUser
        }catch{
            print("FAILED FETCH")
            return false
        }
    }
}

