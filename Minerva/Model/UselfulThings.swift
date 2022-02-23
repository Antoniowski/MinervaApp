//
//  TaskModel.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import Foundation

enum PriorityLevel: String{
    case low = "a"
    case mid = "b"
    case high = "c"
}

func LocalizeStrings(_ string: String)->String{
    return NSLocalizedString(string, comment: "")
}
