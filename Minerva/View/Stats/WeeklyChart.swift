//
//  WeeklyChart.swift
//  Minerva
//
//  Created by Martina Ottaviano on 21/02/22.
//

import Foundation
import SwiftUI

struct WeeklyChart: View {
    
    @State var progressValue: Float = 0.0
    
    var body: some View {
        ZStack{
            
            ZStack {
                ProgressBar(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width*0.6, height: UIScreen.main.bounds.width*0.6)
                    .padding(40.0)
                
                Button (action: {
                    self.incrementProgress()
                }) {
                    HStack{
                        Text("")
                    }
                    .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.8)
                    .border(.green)
                    
                    
                }
            }
            
            
        }
        
    }
    
    func incrementProgress() {
        let randomValue: Float = 0.5
        self.progressValue += randomValue
    }
}

struct ProgressBar1: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 30.0)
                .opacity(0.15)
                .foregroundColor(Color.black)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.default, value: progress)
            
            Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                .font(.system(size: 200))
                .bold()
            
        }
    }
}
struct ContentView_Previews5: PreviewProvider {
    static var previews: some View {
        WeeklyChart()
    }
}
