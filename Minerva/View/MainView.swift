//
//  ContentView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MainView: View {
    let savedTask: TaskControllerCD

    var body: some View {
        TabView{
            MyPlannerView()
                .tabItem{
                    Label("Planner", systemImage: "square.and.pencil")
                }
            Text("Group")
                .tabItem{
                    Label("Group", systemImage: "person.3.fill")
                }
            Text("Stats")
                .tabItem{
                    Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
        .preferredColorScheme(.light)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(savedTask: TaskControllerCD())
    }
}
