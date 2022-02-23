//
//  PercentageManager.swift
//  Minerva
//
//  Created by Antonio Romano on 23/02/22.
//

import Foundation
import SwiftUI

struct PercentageInfo{
    var percentage: Float = 0
    
    var tasksQty: Int = 0
    
    var lowQty: Float = 0
    var midQty: Float = 0
    var highQty: Float = 0
    
    var relLowWeight: Float = 0
    var relMidWeight: Float = 0
    var relHighWeight: Float = 0
}

class PercentageManager{
    private let lowWeight: Float = 0.75
    private let midWeight: Float = 1
    private let highWeight: Float = 1.25
    
    var week: PercentageInfo = PercentageInfo()
    
    //    WEEKDAY
    var monday: PercentageInfo = PercentageInfo()
    var tuesday: PercentageInfo = PercentageInfo()
    var wednesday: PercentageInfo = PercentageInfo()
    var thurday: PercentageInfo = PercentageInfo()
    var friday: PercentageInfo = PercentageInfo()
    var saturday: PercentageInfo = PercentageInfo()
    var sunday: PercentageInfo = PercentageInfo()
    
    
    func UpdateAfterAdd(task: TaskCD, begin: Date, end: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let dateWeekday: String = dateFormatter.string(from: task.date_of_activity ?? Date())
        
        if task.date_of_activity ?? Date() < end && task.date_of_activity ?? Date() > begin{
            week.tasksQty+=1
            switch(task.priority){
            case "a": week.lowQty+=1
            case "b": week.midQty+=1
            case "c": week.highQty+=1
            default: print("SWITCH FAILED")
            }
            
            switch(dateWeekday){
            case "Monday":
                switch(task.priority){
                case "a": monday.lowQty+=1
                case "b": monday.midQty+=1
                case "c": monday.highQty+=1
                default: print("SWITCH FAILED")
                }
            case "Tuesday":
                switch(task.priority){
                case "a": tuesday.lowQty+=1
                case "b": tuesday.midQty+=1
                case "c": tuesday.highQty+=1
                default: print("SWITCH FAILED")
                }
            case "Wednesday":
                switch(task.priority){
                case "a": wednesday.lowQty+=1
                case "b": wednesday.midQty+=1
                case "c": wednesday.highQty+=1
                default: print("SWITCH FAILED")
                }
            case "Thursday":
                switch(task.priority){
                case "a": thurday.lowQty+=1
                case "b": thurday.midQty+=1
                case "c": thurday.highQty+=1
                default: print("SWITCH FAILED")
                }
            case "Friday":
                switch(task.priority){
                case "a": friday.lowQty+=1
                case "b": friday.midQty+=1
                case "c": friday.highQty+=1
                default: print("SWITCH FAILED")
                }
            case "Saturday":
                switch(task.priority){
                case "a": saturday.lowQty+=1
                case "b": saturday.midQty+=1
                case "c": saturday.highQty+=1
                default: print("SWITCH FAILED")
                }
            default:
                switch(task.priority){
                case "a": sunday.lowQty+=1
                case "b": sunday.midQty+=1
                case "c": sunday.highQty+=1
                default: print("SWITCH FAILED")
                }
            }
            WeightCalc(appliedTo: &week)
            switch(dateWeekday){
            case "Monday":
                WeightCalc(appliedTo: &monday)
            case "Tuesday":
                WeightCalc(appliedTo: &tuesday)
            case "Wednesday":
                WeightCalc(appliedTo: &wednesday)
            case "Thursday":
                WeightCalc(appliedTo: &thurday)
            case "Friday":
                WeightCalc(appliedTo: &friday)
            case "Saturday":
                WeightCalc(appliedTo: &saturday)
            default:
                WeightCalc(appliedTo: &sunday)
            }
        }
        
    }
    
    func UpdateAfterDelete(task: TaskCD, begin: Date, end: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let dateWeekday: String = dateFormatter.string(from: task.date_of_activity ?? Date())
        
        if task.date_of_activity ?? Date() < end && task.date_of_activity ?? Date() > begin{
            week.tasksQty-=1
            if task.priority == "Optional(\"a\")"{
                week.lowQty-=1
            }else if task.priority == "Optional(\"b\")"{
                week.midQty-=1
            }else{
                week.highQty-=1
            }
            if week.tasksQty == 0{
                week.relLowWeight = 0
                week.relMidWeight = 0
                week.relHighWeight = 0
                week.percentage = 0
            }else{
                WeightCalc(appliedTo: &week)
            }
            
            switch(dateWeekday){
            case "Monday":
                if task.priority == "Optional(\"a\")"{
                    monday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    monday.midQty-=1
                }else{
                    monday.highQty-=1
                }
                if monday.tasksQty == 0{
                    monday.relLowWeight = 0
                    monday.relMidWeight = 0
                    monday.relHighWeight = 0
                    monday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &monday)
                }
            case "Tuesday":
                if task.priority == "Optional(\"a\")"{
                    tuesday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    tuesday.midQty-=1
                }else{
                    tuesday.highQty-=1
                }
                if tuesday.tasksQty == 0{
                    tuesday.relLowWeight = 0
                    tuesday.relMidWeight = 0
                    tuesday.relHighWeight = 0
                    tuesday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &tuesday)
                }
            case "Wednesday":
                if task.priority == "Optional(\"a\")"{
                    wednesday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    wednesday.midQty-=1
                }else{
                    wednesday.highQty-=1
                }
                if wednesday.tasksQty == 0{
                    wednesday.relLowWeight = 0
                    wednesday.relMidWeight = 0
                    wednesday.relHighWeight = 0
                    wednesday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &wednesday)
                }
            case "Thursday":
                if task.priority == "Optional(\"a\")"{
                    thurday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    thurday.midQty-=1
                }else{
                    thurday.highQty-=1
                }
                if thurday.tasksQty == 0{
                    thurday.relLowWeight = 0
                    thurday.relMidWeight = 0
                    thurday.relHighWeight = 0
                    thurday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &thurday)
                }
            case "Friday":
                if task.priority == "Optional(\"a\")"{
                    friday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    friday.midQty-=1
                }else{
                    friday.highQty-=1
                }
                if friday.tasksQty == 0{
                    friday.relLowWeight = 0
                    friday.relMidWeight = 0
                    friday.relHighWeight = 0
                    friday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &friday)
                }
            case "Saturday":
                if task.priority == "Optional(\"a\")"{
                    saturday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    saturday.midQty-=1
                }else{
                    saturday.highQty-=1
                }
                if saturday.tasksQty == 0{
                    saturday.relLowWeight = 0
                    saturday.relMidWeight = 0
                    saturday.relHighWeight = 0
                    saturday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &saturday)
                }
            default:
                if task.priority == "Optional(\"a\")"{
                    sunday.lowQty-=1
                }else if task.priority == "Optional(\"b\")"{
                    sunday.midQty-=1
                }else{
                    sunday.highQty-=1
                }
                if sunday.tasksQty == 0{
                    sunday.relLowWeight = 0
                    sunday.relMidWeight = 0
                    sunday.relHighWeight = 0
                    sunday.percentage = 0
                }else{
                    WeightCalc(appliedTo: &sunday)
                }
            }
        }
    }
    
    func UpdateAfterUpdateCompletedStatus(task: TaskCD, begin: Date, end: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let dateWeekday: String = dateFormatter.string(from: task.date_of_activity ?? Date())
        
        if task.date_of_activity ?? Date() < end && task.date_of_activity ?? Date() > begin{
            if task.completed{
                if task.priority == "Optional(\"a\")"{
                    week.percentage += week.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    week.percentage += week.relMidWeight
                }else{
                    week.percentage += week.relHighWeight
                }
                switch(dateWeekday){
                case "Monday":
                    if task.priority == "Optional(\"a\")"{
                        monday.percentage += monday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        monday.percentage += monday.relMidWeight
                    }else{
                        monday.percentage += monday.relHighWeight
                    }
                case "Tuesday":
                    if task.priority == "Optional(\"a\")"{
                        tuesday.percentage += tuesday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        tuesday.percentage += tuesday.relMidWeight
                    }else{
                        tuesday.percentage += tuesday.relHighWeight
                    }
                case "Wednesday":
                    if task.priority == "Optional(\"a\")"{
                        wednesday.percentage += wednesday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        wednesday.percentage += wednesday.relMidWeight
                    }else{
                        wednesday.percentage += wednesday.relHighWeight
                    }
                case "Thursday":
                    if task.priority == "Optional(\"a\")"{
                        thurday.percentage += thurday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        thurday.percentage += thurday.relMidWeight
                    }else{
                        thurday.percentage += thurday.relHighWeight
                    }
                case "Friday":
                    if task.priority == "Optional(\"a\")"{
                        friday.percentage += friday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        friday.percentage += friday.relMidWeight
                    }else{
                        friday.percentage += friday.relHighWeight
                    }
                case "Saturday":
                    if task.priority == "Optional(\"a\")"{
                        saturday.percentage += saturday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        saturday.percentage += saturday.relMidWeight
                    }else{
                        saturday.percentage += saturday.relHighWeight
                    }
                default:
                    if task.priority == "Optional(\"a\")"{
                        sunday.percentage += sunday.relLowWeight
                    }else if task.priority == "Optional(\"b\")"{
                        sunday.percentage += sunday.relMidWeight
                    }else{
                        sunday.percentage += sunday.relHighWeight
                    }
                }
            }else{
                if task.priority == "Optional(\"a\")"{
                    week.percentage -= week.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    week.percentage -= week.relMidWeight
                }else{
                    week.percentage -= week.relHighWeight
                }
            }
            switch(dateWeekday){
            case "Monday":
                if task.priority == "Optional(\"a\")"{
                    monday.percentage -= monday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    monday.percentage -= monday.relMidWeight
                }else{
                    monday.percentage -= monday.relHighWeight
                }
            case "Tuesday":
                if task.priority == "Optional(\"a\")"{
                    tuesday.percentage -= tuesday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    tuesday.percentage -= tuesday.relMidWeight
                }else{
                    tuesday.percentage -= tuesday.relHighWeight
                }
            case "Wednesday":
                if task.priority == "Optional(\"a\")"{
                    wednesday.percentage -= wednesday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    wednesday.percentage -= wednesday.relMidWeight
                }else{
                    wednesday.percentage -= wednesday.relHighWeight
                }
            case "Thursday":
                if task.priority == "Optional(\"a\")"{
                    thurday.percentage -= thurday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    thurday.percentage -= thurday.relMidWeight
                }else{
                    thurday.percentage -= thurday.relHighWeight
                }
            case "Friday":
                if task.priority == "Optional(\"a\")"{
                    friday.percentage -= friday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    friday.percentage -= friday.relMidWeight
                }else{
                    friday.percentage -= friday.relHighWeight
                }
            case "Saturday":
                if task.priority == "Optional(\"a\")"{
                    saturday.percentage -= saturday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    saturday.percentage -= saturday.relMidWeight
                }else{
                    saturday.percentage -= saturday.relHighWeight
                }
            default:
                if task.priority == "Optional(\"a\")"{
                    sunday.percentage -= sunday.relLowWeight
                }else if task.priority == "Optional(\"b\")"{
                    sunday.percentage -= sunday.relMidWeight
                }else{
                    sunday.percentage -= sunday.relHighWeight
                }
            }
        }
    }
    
    func WeightCalc(){
        week.relLowWeight = lowWeight/(week.lowQty*lowWeight + week.midQty*midWeight + week.highQty*highWeight)
        week.relMidWeight = midWeight/(week.lowQty*lowWeight + week.midQty*midWeight + week.highQty*highWeight)
        week.relHighWeight = highWeight/(week.lowQty*lowWeight + week.midQty*midWeight + week.highQty*highWeight)
        
        
        monday.relLowWeight = lowWeight/(monday.lowQty*lowWeight + monday.midQty*midWeight + monday.highQty*highWeight)
        monday.relMidWeight = midWeight/(monday.lowQty*lowWeight + monday.midQty*midWeight + monday.highQty*highWeight)
        monday.relHighWeight = highWeight/(monday.lowQty*lowWeight + monday.midQty*midWeight + monday.highQty*highWeight)
        
        tuesday.relLowWeight = lowWeight/(tuesday.lowQty*lowWeight + tuesday.midQty*midWeight + tuesday.highQty*highWeight)
        tuesday.relMidWeight = midWeight/(tuesday.lowQty*lowWeight + tuesday.midQty*midWeight + tuesday.highQty*highWeight)
        tuesday.relHighWeight = highWeight/(tuesday.lowQty*lowWeight + tuesday.midQty*midWeight + tuesday.highQty*highWeight)
        
        wednesday.relLowWeight = lowWeight/(wednesday.lowQty*lowWeight + wednesday.midQty*midWeight + wednesday.highQty*highWeight)
        wednesday.relMidWeight = midWeight/(wednesday.lowQty*lowWeight + wednesday.midQty*midWeight + wednesday.highQty*highWeight)
        wednesday.relHighWeight = highWeight/(wednesday.lowQty*lowWeight + wednesday.midQty*midWeight + wednesday.highQty*highWeight)
        
        thurday.relLowWeight = lowWeight/(thurday.lowQty*lowWeight + thurday.midQty*midWeight + thurday.highQty*highWeight)
        thurday.relMidWeight = midWeight/(thurday.lowQty*lowWeight + thurday.midQty*midWeight + thurday.highQty*highWeight)
        thurday.relHighWeight = highWeight/(thurday.lowQty*lowWeight + thurday.midQty*midWeight + thurday.highQty*highWeight)
        
        friday.relLowWeight = lowWeight/(friday.lowQty*lowWeight + friday.midQty*midWeight + friday.highQty*highWeight)
        friday.relMidWeight = midWeight/(friday.lowQty*lowWeight + friday.midQty*midWeight + friday.highQty*highWeight)
        friday.relHighWeight = highWeight/(friday.lowQty*lowWeight + friday.midQty*midWeight + friday.highQty*highWeight)
        
        saturday.relLowWeight = lowWeight/(saturday.lowQty*lowWeight + saturday.midQty*midWeight + saturday.highQty*highWeight)
        saturday.relMidWeight = midWeight/(saturday.lowQty*lowWeight + saturday.midQty*midWeight + saturday.highQty*highWeight)
        saturday.relHighWeight = highWeight/(saturday.lowQty*lowWeight + saturday.midQty*midWeight + saturday.highQty*highWeight)
        
        sunday.relLowWeight = lowWeight/(sunday.lowQty*lowWeight + sunday.midQty*midWeight + sunday.highQty*highWeight)
        sunday.relMidWeight = midWeight/(sunday.lowQty*lowWeight + sunday.midQty*midWeight + sunday.highQty*highWeight)
        sunday.relHighWeight = highWeight/(sunday.lowQty*lowWeight + sunday.midQty*midWeight + sunday.highQty*highWeight)

    }
    
    func WeightCalc(appliedTo percentElement: inout PercentageInfo){
        percentElement.relLowWeight = lowWeight/(percentElement.lowQty*lowWeight+percentElement.midQty*midWeight+percentElement.highQty*highWeight)
        percentElement.relMidWeight = midWeight/(percentElement.lowQty*lowWeight+percentElement.midQty*midWeight+percentElement.highQty*highWeight)
        percentElement.relHighWeight = highWeight/(percentElement.lowQty*lowWeight+percentElement.midQty*midWeight+percentElement.highQty*highWeight)
    }
    
    
    func ResetQty(appliedTo percentElement: inout PercentageInfo){
        percentElement.tasksQty = 0
        percentElement.lowQty = 0
        percentElement.midQty = 0
        percentElement.highQty = 0
    }
    
    func PercentageReset(appliedTo percentElement: inout PercentageInfo){
        percentElement.percentage = 0
    }
    
    func TasksQtyUpdate(appliedTo percentElement: inout PercentageInfo, T: TaskCD, begin: Date, end: Date){
        if T.date_of_activity ?? Date() < end && T.date_of_activity ?? Date() > begin{
            percentElement.tasksQty += 1
            if T.priority == "a"{
                percentElement.lowQty += 1
            }else if T.priority == "b"{
                percentElement.midQty += 1
            }else{
                percentElement.highQty += 1
            }
        }
    }
    
    func PercentageUpdate(appliedTo percentElement: inout PercentageInfo, T: TaskCD, begin: Date, end: Date){
        if T.date_of_activity ?? Date() < end && T.date_of_activity ?? Date() > begin{
            if T.completed{
                if T.priority == "a"{
                    percentElement.percentage += percentElement.relLowWeight
                }else if T.priority == "b"{
                    percentElement.percentage += percentElement.relMidWeight
                }else{
                    percentElement.percentage += percentElement.relHighWeight
                }
            }
        }
    }
}
