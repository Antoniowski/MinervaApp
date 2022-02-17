//
//  TaskModel.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

enum PriorityLevel: String{
    case low = "a"
    case mid = "b"
    case high = "c"
}

struct TaskModel{
    var title: String
    var description: String
    var priority: PriorityLevel
    var completed: Bool
}
