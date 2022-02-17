//
//  NavViewStats.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

extension MainView {
    var statsNavView: some View {
        NavigationView{
            StatsView()
                .toolbar {
                    ToolbarItem(placement: .navigation, content: {
                        Text("Statistics")
                            .font(.custom("Noteworthy-Bold", size: 35))
                    })
                }
                
        }
    }
}
