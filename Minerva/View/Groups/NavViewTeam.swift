//
//  NavViewTeam.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

extension MainView {
    var teamNavView: some View {
        NavigationView{
            TeamView()
                .toolbar {
                    ToolbarItem(placement: .navigation, content: {
                        Text("Groups")
                            .font(.largeTitle).bold()
//                            .font(.custom("Noteworthy-Bold", size: 35))
                    })
                }
                
        }
    }
}
