//
//  StatsView.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

struct StatsView: View {
    @EnvironmentObject var sharedData: TaskStore
    var body: some View{
        VStack{
            
            ScrollView{
                WeeklyChart()
                Text("Percentage of tasks completed this week")
                    . frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/4.6, alignment: .leading)
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0...6, id: \.self){_ in
                            CardComponent()
                        }
                    }
                    .padding(.horizontal, 15)
                }
                
                
                Text("Badges")
                    .font(.custom("Noteworthy-Bold", size: 30))
                    . frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/8, alignment: .leading)
                
            }
            
        }
        .onAppear(perform: {
        })
    }
}
//struct ContentView_Previews4: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}
