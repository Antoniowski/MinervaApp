//
//  BadgeManager.swift
//  Minerva
//
//  Created by Antonio Romano on 24/02/22.
//

import Foundation
import SwiftUI

struct Badge: Hashable{
//    static func == (lhs: Badge, rhs: Badge) -> Bool{}
    var isDone: Bool = false
    var title: String
    var description: String
    var image: String
    var unlockMethod: String = ""
}

class BadgeManager{
    @EnvironmentObject var sharedData: TaskStore
    private var date = Date()
}
