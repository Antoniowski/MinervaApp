//
//  DateManager.swift
//  Minerva
//
//  Created by Antonio Romano on 22/02/22.
//

import Foundation
import SwiftUI

class DateManager{
    private let week: Double = (60*60*24*7)
    private let day: Double = (60*60*24)
    
    var startingDay: Date  = Date()
    var endingDay: Date = Date()
    
    init(){
        GetLastMonday()
        GetSunday()
    }
    
    func GetLastMonday(){
        let today: Date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        let todayWeekday: String = dateFormatter.string(from: today)
        let currentTime: Double = timeFormatter.string(from: today).numberOfSeconds()
        var monday: Date
        
        switch(todayWeekday){
        case "Monday", "lunedì":
            monday = today-currentTime
        case "Tuesday", "martedì":
            monday = today-day-currentTime
        case "Wednesday", "mercoledì":
            monday = today-2*day-currentTime
        case "Thursday", "giovedì":
            monday = today-3*day-currentTime
        case "Friday", "venerdì":
            monday = today-4*day-currentTime
        case "Saturday", "sabato":
            monday = today-5*day-currentTime
        default:
            monday = today-6*day-currentTime
        }
        startingDay = monday
    }
    
    func GetSunday(){
        endingDay = startingDay + week - 1
    }
}


extension String {
    func numberOfSeconds() -> Double {
       let components: Array = self.components(separatedBy: ":")
       let hours = Double(components[0]) ?? 0
       let minutes = Double(components[1]) ?? 0
       let seconds = Double(components[2]) ?? 0
       return (hours * 3600) + (minutes * 60) + seconds
   }
}
