//
//  TaskStore.swift
//  Minerva
//
//  Created by Antonio Romano on 18/02/22.
//

import Foundation
import CoreData
import SwiftUI

class TaskStore: ObservableObject{
    @Published var tasks: [TaskCD] = []
    @Published var orderedTask: [TaskCD] = []
    
    @Published var dateManager = DateManager()
    @Published var percentageManager = PercentageManager()
    @Published var badgeManager = BadgeManager()

    
    init(){
        FetchTasks()
    }
    
//    ****************************************
//    FETCH FUNCTIONS ************************
//    ****************************************

    func FetchTasks(){
        let request = NSFetchRequest<TaskCD>(entityName: "TaskCD")
        do{
            tasks = try TaskControllerCD.shared.dataContainer.viewContext.fetch(request)
        }catch{
            print("ERROR IN FETCHING TASKS error \(error)")
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
    
    //    **********************************
    //ADD FUNC *****************************
    //    **********************************
    
    
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
            dateManager.GetLastMonday()
            dateManager.GetSunday()
            percentageManager.UpdateAfterAdd(task: task, begin: dateManager.startingDay, end: dateManager.endingDay)
        }catch{
            print("Failed save")
        }
    }
    
    
//    *********************************************
//    DELETE FUNCTIONS  ***************************
//    *********************************************

    
    func DeleteTask(task: TaskCD){

        TaskControllerCD.shared.dataContainer.viewContext.delete(task)
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
            dateManager.GetLastMonday()
            dateManager.GetSunday()
            percentageManager.UpdateAfterDelete(task: task, begin: dateManager.startingDay, end: dateManager.endingDay)
            }catch{
            TaskControllerCD.shared.dataContainer.viewContext.rollback()
            print("Delete Failed")
        }
    }
    
    
    //    *********************************************
    //    UPDATE FUNCTIONS
    //    *********************************************

    
    func UpdateTask2(task: TaskCD, title: String, desc: String, priority: PriorityLevel){
        let taskAppoggio = task
        DeleteTask(task: task)
        AddTask(title: title, description: desc, priority: priority, completed: taskAppoggio.completed, date: taskAppoggio.date_of_activity ?? Date())
    }

    
    func UpdateTask(task: TaskCD, isCompleted: Bool){
        task.completed = isCompleted
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
                dateManager.GetLastMonday()
                dateManager.GetSunday()
                percentageManager.UpdateAfterUpdateCompletedStatus(task: task, begin: dateManager.startingDay, end: dateManager.endingDay)
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
    
    //    *********************************************
    //    GET FUNCTIONS *****************************
    //    *********************************************

    
    
    func GetAllTaskArray()->[TaskCD]{
        let fetchRequest: NSFetchRequest<TaskCD> = TaskCD.fetchRequest()
        do{
            return try TaskControllerCD.shared.dataContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    


//    *********************************************
//    ****** FUNZIONI PER LA PERCENTUALE **********
//    *********************************************
    
    func TotalTasksQtyUpdate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        var day: String
        
        percentageManager.ResetQty(appliedTo: &percentageManager.week)
        percentageManager.ResetQty(appliedTo: &percentageManager.monday)
        percentageManager.ResetQty(appliedTo: &percentageManager.tuesday)
        percentageManager.ResetQty(appliedTo: &percentageManager.wednesday)
        percentageManager.ResetQty(appliedTo: &percentageManager.thurday)
        percentageManager.ResetQty(appliedTo: &percentageManager.friday)
        percentageManager.ResetQty(appliedTo: &percentageManager.saturday)
        percentageManager.ResetQty(appliedTo: &percentageManager.sunday)

        FetchTasks()
        dateManager.GetLastMonday()
        dateManager.GetSunday()
        
        for T in tasks{
            day = dateFormatter.string(from: T.date_of_activity ?? Date())
            percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.week, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            switch(day){
            case "Monday", "luned??": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.monday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Tuesday", "marted??": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.tuesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Wednesday", "mercoled??": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.wednesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Thursday", "gioved??": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.thurday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Friday", "venerd??": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.friday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Saturday", "sabato": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.saturday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            default: percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.sunday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            }
        }
    }
    
    func TotalPercentageUpdate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        var day: String
        percentageManager.PercentageReset(appliedTo: &percentageManager.week)
        percentageManager.PercentageReset(appliedTo: &percentageManager.monday)
        percentageManager.PercentageReset(appliedTo: &percentageManager.tuesday)
        percentageManager.PercentageReset(appliedTo: &percentageManager.wednesday)
        percentageManager.PercentageReset(appliedTo: &percentageManager.thurday)
        percentageManager.PercentageReset(appliedTo: &percentageManager.friday)
        percentageManager.PercentageReset(appliedTo: &percentageManager.saturday)
        percentageManager.PercentageReset(appliedTo: &percentageManager.sunday)
        
        TotalTasksQtyUpdate()
        
        percentageManager.WeightCalc(appliedTo: &percentageManager.week)
        if percentageManager.monday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.monday)
        }
        if percentageManager.tuesday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.tuesday)
        }
        if percentageManager.wednesday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.wednesday)
        }
        if percentageManager.thurday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.thurday)
        }
        if percentageManager.friday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.friday)
        }
        if percentageManager.saturday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.saturday)
        }
        if percentageManager.sunday.tasksQty != 0{
            percentageManager.WeightCalc(appliedTo: &percentageManager.sunday)
        }
        
        FetchTasks()
        dateManager.GetLastMonday()
        dateManager.GetSunday()
        
        
        for T in tasks{
//            WEEK PERCENTAGE
            percentageManager.PercentageUpdate(appliedTo: &percentageManager.week,T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            
            day = dateFormatter.string(from: T.date_of_activity ?? Date())
            switch(day){
            case "Monday","luned??": percentageManager.PercentageUpdate(appliedTo: &percentageManager.monday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Tuesday", "marted??": percentageManager.PercentageUpdate(appliedTo: &percentageManager.tuesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Wednesday", "mercoled??": percentageManager.PercentageUpdate(appliedTo: &percentageManager.wednesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Thursday", "gioved??": percentageManager.PercentageUpdate(appliedTo: &percentageManager.thurday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Friday", "venerd??": percentageManager.PercentageUpdate(appliedTo: &percentageManager.friday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Saturday", "sabato": percentageManager.PercentageUpdate(appliedTo: &percentageManager.saturday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            default: percentageManager.PercentageUpdate(appliedTo: &percentageManager.sunday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            }
        }
        badgeManager.MultitaskerControl(percentageChecked: percentageManager.week.percentage)
        badgeManager.PerfectControl(percentageChecked: percentageManager.week.percentage)
        day = dateFormatter.string(from: Date())
        switch(day){
        case "Monday","luned??": badgeManager.TrooperControl(percentageChecked: percentageManager.monday.percentage)
        case "Tuesday", "marted??": badgeManager.TrooperControl(percentageChecked: percentageManager.tuesday.percentage)
        case "Wednesday", "mercoled??": badgeManager.TrooperControl(percentageChecked: percentageManager.wednesday.percentage)
        case "Thursday", "gioved??": badgeManager.TrooperControl(percentageChecked: percentageManager.thurday.percentage)
        case "Friday", "venerd??": badgeManager.TrooperControl(percentageChecked: percentageManager.friday.percentage)
        case "Saturday", "sabato": badgeManager.TrooperControl(percentageChecked: percentageManager.saturday.percentage)
        default: badgeManager.TrooperControl(percentageChecked: percentageManager.sunday.percentage)
        }
    }
    
    func dateControl(controlledDate: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: controlledDate)
    }
    
}


