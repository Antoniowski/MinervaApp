//
//  ContentView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MainView: View {
    @AppStorage("newUser") var newUser: Bool = true

    @EnvironmentObject var sharedData: TaskStore
    @State var editStatus: Bool = false
    var body: some View {
        TabView{
            myPlannerNavView
                .tabItem{
                    Label("Planner", systemImage: "square.and.pencil")
                }
            teamNavView
                .tabItem{
                    Label("Group", systemImage: "person.3.fill")
                }
            statsNavView
                .tabItem{
                    Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
        .sheet(isPresented: $newUser) {
            OnboardingView()
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
