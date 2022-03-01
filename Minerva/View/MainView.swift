//
//  ContentView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MainView: View {
    @AppStorage("newUser") var newUser: Bool = true
    @AppStorage("lastLogin") var lastLogin: Date = Date()
    private let dateFormatter = DateFormatter()

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
        .onAppear(perform: {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if dateFormatter.string(from: lastLogin) != dateFormatter.string(from: Date()){
                sharedData.badgeManager.DailyReset()

                if sharedData.dateManager.GetMonday(referredDate: lastLogin) != sharedData.dateManager.GetMonday(referredDate: Date()){
                    sharedData.badgeManager.WeeklyReset()
                }
                lastLogin = Date()
            }
        })
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
