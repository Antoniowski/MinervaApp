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

func LocalizeStrings(_ string: String, comment: String = "")->String{
    return NSLocalizedString(string, comment: comment)
}


extension Date: RawRepresentable{
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String{
        return Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
