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
            MyPlannerView(editStatus: $editStatus)
                .toolbar {
                    ToolbarItem(placement: .navigation, content: {
                        Text("My Planner")
                            .font(.largeTitle).bold()
//                            .font(.custom("Noteworthy-Bold", size: 35))
                    })
                    
                    ToolbarItem(placement: .primaryAction, content: {
                        Button(editStatus == false ? "Edit" : "Done"){
                            editStatus.toggle()
                        }
                    })
                }
                
        }
    }
}
