//
//  TaskStore.swift
//  Minerva
//
//  Created by Antonio Romano on 18/02/22.
//

import Foundation
import CoreData

class TaskStore: ObservableObject{
    @Published var tasks: [TaskCD] = []
    @Published var orderedTask: [TaskCD] = []
    init(){
        FetchTasks()
    }
    
    func FetchTasks(){
        let request = NSFetchRequest<TaskCD>(entityName: "TaskCD")
        do{
            tasks = try TaskControllerCD.shared.dataContainer.viewContext.fetch(request)
        }catch{
            print("ERROR IN FETCHING error \(error)")
        }
    }
    //ADD FUNC
    func AddTask(title: String, description: String, priority: PriorityLevel, completed: Bool = false, date: Date = Date()){
        let task = TaskCD(context: TaskControllerCD.shared.dataContainer.viewContext)
        task.title = title
        task.activity_description = description
        task.priority = priority.rawValue
        task.completed = completed
        task.date_of_activity = date
        switch(priority.rawValue){
        case "a":
            task.peso = 0.75
        case "b":
            task.peso = 1
        case "c":
            task.peso = 1.25
        default:
            task.peso = 1
        }
        
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            print("Failed save")
        }
    }
    
    func AddStatusBool(){
        let statusBool = AppStatusInfo(context: TaskControllerCD.shared.dataContainer.viewContext)
        
    newUserControll:
        if GetAppInfo().isEmpty == false{
            break newUserControll
        }else{
            statusBool.newUser = true
            
            do{
                try TaskControllerCD.shared.dataContainer.viewContext.save()
            }catch{
                print("Add Status Bool Failed")
            }
            
        }
    }
    
    func DeleteTask(task: TaskCD){
        TaskControllerCD.shared.dataContainer.viewContext.delete(task)
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Delete Failed")
        }
    }
    
    
    //    UPDATE FUNCTIONS
    
    func UpdateTask2(task: TaskCD, title: String, desc: String, priority: PriorityLevel){
        let taskAppoggio = task
        DeleteTask(task: task)
        AddTask(title: title, description: desc, priority: priority, completed: taskAppoggio.completed, date: taskAppoggio.date_of_activity ?? Date())
    }
    
//    func UpdateTask(task: TaskCD, title: String, desc: String, priority: PriorityLevel){
//        task.title = title
//        task.activity_description = desc
//        task.priority = priority.rawValue
//        do{
//            try TaskControllerCD.shared.dataContainer.viewContext.save()
//        }catch{
//            TaskControllerCD.shared.dataContainer.viewContext.rollback()
//            print("Update Failed")
//        }
//    }
    
    func UpdateTask(task: TaskCD, isCompleted: Bool){
        task.completed = isCompleted
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    
    func UpdateTask(task: TaskCD, title: String){
        task.title = title
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    func UpdateTask(task: TaskCD, desc: String){
        task.activity_description = desc
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    func UpdateTask(task: TaskCD, date: Date){
        task.date_of_activity = date
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    
    func UpdateTask(task: TaskCD, priority: PriorityLevel){
        task.priority = priority.rawValue
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Update Failed")
        }
    }
    
    func SetFalseNewUser(user: AppStatusInfo){
        user.newUser = false
    }
    
    //    GET FUNC
    func GetAllTaskArray()->[TaskCD]{
        let fetchRequest: NSFetchRequest<TaskCD> = TaskCD.fetchRequest()
        do{
            return try TaskControllerCD.shared.dataContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    
    func FetchOrdered(){
        let array = GetAllTaskArray()
        var arrayLow: [TaskCD] = []
        var arrayMid: [TaskCD] = []
        var arrayHigh: [TaskCD] = []
        
        if array.isEmpty{
            orderedTask = []
            print("No Items")
        }else{
            for T in array{
                switch(T.priority){
                case "a": arrayLow.append(T)
                case "b": arrayMid.append(T)
                case "c": arrayHigh.append(T)
                default: print("ciao")
                }
            }
            orderedTask = arrayHigh+arrayMid+arrayLow
        }
    }
    
    //recupera il vettore dei bool
    func GetAppInfo()->[AppStatusInfo]{
        let fetchRequest: NSFetchRequest<AppStatusInfo> = AppStatusInfo.fetchRequest()
        do{
            return try TaskControllerCD.shared.dataContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func GetNewUserStatus()->Bool{
        let fetchRequest: NSFetchRequest<AppStatusInfo> = AppStatusInfo.fetchRequest()
        do{
            return try TaskControllerCD.shared.dataContainer.viewContext.fetch(fetchRequest)[0].newUser
        }catch{
            print("FAILED FETCH")
            return false
        }
    }
}

