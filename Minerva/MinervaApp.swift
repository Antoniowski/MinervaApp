//
//  MinervaApp.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

@main
struct MinervaApp: App {
    @StateObject var sharedData = TaskStore()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(sharedData)
        }
    }
}
