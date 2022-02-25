//
//  BadgeManager.swift
//  Minerva
//
//  Created by Antonio Romano on 25/02/22.
//

import Foundation
import SwiftUI

class BadgeManager{
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
    
    func MultitaskerControl(percentageChecked: Float){
        if percentageChecked >= 0.5{
            if multitaskerIsDone == false{
                multitaskerIsDone = true
                multitaskerTotalQty += 1
            }
        }else{
            if multitaskerIsDone == true{
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
