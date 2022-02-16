//
//  NavViewMyPlanner.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

extension MainView {
    var myPlannerNavView: some View {
        NavigationView{
            MyPlannerView()
                .toolbar {
                    ToolbarItem(placement: .navigation, content: {
                        Text("My Planner")
                            .font(.custom("Noteworthy-Bold", size: 35))
                    })
                }
                
        }
    }
}
