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
                print("MLTSK DONE")
                print("\(multitaskerTotalQty)")
            }
        }else{
            if multitaskerIsDone == true{
                multitaskerIsDone = false
                multitaskerTotalQty -= 1
                print("MLTSK UNDONE")
                print("\(multitaskerTotalQty)")

            }
        }
    }
    
    func TrooperControl(percentageChecked: Float){
        if percentageChecked == 1{
            if trooperIsDone == false{
                trooperIsDone = true
                trooperTotalQty += 1
                print("TROOPER DONE")
                print("\(trooperTotalQty)")
            }
        }else{
            if trooperIsDone == true{
                trooperIsDone = false
                trooperTotalQty -= 1
                print("TROOPER UNDONE")
                print("\(trooperTotalQty)")

            }
        }
    }
    
    func PerfectControl(percentageChecked: Float){
        if percentageChecked >= 1{
            if perfectIsDone == false{
                perfectIsDone = true
                perfectionistTotalQty += 1
                print("MLTSK DONE")
                print("\(perfectionistTotalQty)")
            }
        }else{
            if perfectIsDone == true{
                perfectIsDone = false
                perfectionistTotalQty -= 1
                print("MLTSK UNDONE")
                print("\(perfectionistTotalQty)")

            }
        }
    }
    
    func DailyReset(){
        trooperIsDone = false
    }
    
    func WeeklyReset(){
        DailyReset()
        multitaskerIsDone = false
        socialIsDone = false
        perfectIsDone = false
    }

}

struct Badge: Hashable{
    var title: String
    var description: String
    var image: String
}
