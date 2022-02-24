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
    
    @Published var weekBadges: [BadgeCD] = []
    
    @Published var dateManager = DateManager()
    @Published var percentageManager = PercentageManager()
    
    @AppStorage("multitaskerTotalQty") var multitaskerTotalQty: Int = 0
    @AppStorage("trooperTotalQty") var trooperTotalQty: Int = 0
    @AppStorage("socialTotalQty") var socialTotalQty: Int = 0
    @AppStorage("perfectionistTotalQty") var perfectionistTotalQty: Int = 0
    
    @AppStorage("multitaskerIsDone") var multitaskerIsDone: Bool = false
    @AppStorage("trooperIsDone") var trooperIsDone: Bool = false
    @AppStorage("socialIsDone") var socialIsDone: Bool = false
    @AppStorage("perfectIsDone") var perfectIsDone: Bool = false
    
    private enum badgeTitle: String{
        case multitasker = "The Multitasker"
        case trooper = "The Trooper"
        case social = "The Social"
        case perfectionist = "The Perfectionist"
    }
    
    init(){
        FetchTasks()
        FetchBadges()
    }
//    FETCH FUNCTIONS ************************
    func FetchTasks(){
        let request = NSFetchRequest<TaskCD>(entityName: "TaskCD")
        do{
            tasks = try TaskControllerCD.shared.dataContainer.viewContext.fetch(request)
        }catch{
            print("ERROR IN FETCHING TASKS error \(error)")
        }
    }
    
    func FetchBadges(){
        let request = NSFetchRequest<BadgeCD>(entityName: "BadgeCD")
        do{
            weekBadges = try TaskControllerCD.shared.dataContainer.viewContext.fetch(request)
        }catch{
            print("ERROR IN FETCHING BADGES error \(error)")
        }
    }
    
    //ADD FUNC *****************************
    
    
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
    
    
    func AddNewBadge(title: String, description: String, date: Date, image: String){
        let badge = BadgeCD(context: TaskControllerCD.shared.dataContainer.viewContext)
        badge.title = title
        badge.descriptionOfArchievement = description
        badge.date = date
        badge.image = image
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
        }catch{
            print("Failed save")
        }
    }
    
//    DELETE FUNCTIONS  ****************************
    
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
    
    func DeleteTask(badge: BadgeCD){
        TaskControllerCD.shared.dataContainer.viewContext.delete(badge)
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

    
    func UpdateTask(task: TaskCD, isCompleted: Bool){
        task.completed = isCompleted
        do{
            try TaskControllerCD.shared.dataContainer.viewContext.save()
                dateManager.GetLastMonday()
                dateManager.GetSunday()
                percentageManager.UpdateAfterUpdateCompletedStatus(task: task, begin: dateManager.startingDay, end: dateManager.endingDay)
                MultitaskerControl()
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

    
    //    ******FUNZIONI PER LA PERCENTUALE******
    
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
            case "Monday", "lunedì": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.monday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Tuesday", "martedì": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.tuesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Wednesday", "mercoledì": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.wednesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Thursday", "giovedì": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.thurday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Friday", "venerdì": percentageManager.TasksQtyUpdate(appliedTo: &percentageManager.friday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
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
            MultitaskerControl()
            
            day = dateFormatter.string(from: T.date_of_activity ?? Date())
            switch(day){
            case "Monday","lunedì": percentageManager.PercentageUpdate(appliedTo: &percentageManager.monday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Tuesday", "martedì": percentageManager.PercentageUpdate(appliedTo: &percentageManager.tuesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Wednesday", "mercoledì": percentageManager.PercentageUpdate(appliedTo: &percentageManager.wednesday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Thursday", "giovedì": percentageManager.PercentageUpdate(appliedTo: &percentageManager.thurday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Friday", "venerdì": percentageManager.PercentageUpdate(appliedTo: &percentageManager.friday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            case "Saturday", "sabato": percentageManager.PercentageUpdate(appliedTo: &percentageManager.saturday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            default: percentageManager.PercentageUpdate(appliedTo: &percentageManager.sunday, T: T, begin: dateManager.startingDay, end: dateManager.endingDay)
            }
        }
    }
    
    func dateControl(controlledDate: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: controlledDate)
    }
    
    
    
    
    
    
//     *********************************************
//    FUNZIONI PER IL CONTROLLO DELLA SEZIONE BADGE
//    **********************************************
    
    
    
    
    func MultitaskerControl(){
        if percentageManager.week.percentage >= 0.5{
            if multitaskerIsDone == false{
                multitaskerIsDone = true
                multitaskerTotalQty += 1
            }
        }else{
            if multitaskerIsDone{
                multitaskerIsDone = false
                multitaskerTotalQty -= 1
            }
        }
    }
}

struct Badge: Hashable{
    var title: String
    var description: String
    var image: String
}

