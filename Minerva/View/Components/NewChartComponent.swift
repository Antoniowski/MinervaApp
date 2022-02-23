//
//  NewChartComponent.swift
//  Minerva
//
//  Created by Martina Ottaviano on 21/02/22.
//

import Foundation
import SwiftUI

struct NewChartComponent: View {
    @EnvironmentObject var sharedData: TaskStore
    
    @State var progressValue: Float = 0.0
    @Binding var weekday: String
    
    var body: some View {
        ZStack{
            taskColor
                .edgesIgnoringSafeArea(.all)
            ProgressBarDay(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.width*0.3)
                    .padding(40.0)
        }
        .onAppear(perform: {
            print("\(sharedData.percentageManager.monday.tasksQty)")
            self.incrementProgress()
        })
    }
    
    func incrementProgress() {
        switch(weekday){
        case "Monday": self.progressValue = sharedData.percentageManager.monday.percentage
        case "Tuesday": self.progressValue = sharedData.percentageManager.tuesday.percentage
        case "Wednesday": self.progressValue = sharedData.percentageManager.wednesday.percentage
        case "Thursday": self.progressValue = sharedData.percentageManager.thurday.percentage
        case "Friday": self.progressValue = sharedData.percentageManager.friday.percentage
        case "Saturday": self.progressValue = sharedData.percentageManager.saturday.percentage
        default: self.progressValue = sharedData.percentageManager.sunday.percentage
        }
    }
}

struct ProgressBarDay: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 16.0)
                .opacity(0.15)
                .foregroundColor(Color.black)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 16.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.default, value: progress)
            
            Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                .font(.system(size: 28))
                .bold()
            
        }
    }
}
//struct ContentView_Previews3: PreviewProvider {
//    static var previews: some View {
//        NewChartComponent()
//            .preferredColorScheme(.dark)
//    }
//}
