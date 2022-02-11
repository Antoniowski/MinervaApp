//
//  ContentView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            Text("Hello")
                .tabItem{
                    Label("Planner", systemImage: "square.and.pencil")
                }
            Text("Group")
                .tabItem{
                    Label("Group", systemImage: "person.3.fill")
                }
            Text("Hello3")
                .tabItem{
                    Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
