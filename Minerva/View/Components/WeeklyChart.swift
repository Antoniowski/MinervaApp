//
//  WeeklyChart.swift
//  Minerva
//
//  Created by Martina Ottaviano on 21/02/22.
//

import Foundation
import SwiftUI

struct WeeklyChart: View {
    @EnvironmentObject var sharedData: TaskStore
    @Environment(\.colorScheme) var colorScheme
    @State var progressValore: Float = 0.0
    
    var body: some View {
        ZStack{
            
            ZStack {
                ProgressBarWeek(progress: self.$progressValore)
                    .frame(width: UIScreen.main.bounds.width*0.6, height: UIScreen.main.bounds.width*0.6)
                    .padding(40.0)
                
                Button (action: {

                }) {
                    HStack{
                        Text("")
                    }
                    .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.8)  
                }
            }
        }
        .onAppear(perform: {
            sharedData.TotalPercentageUpdate()
            incrementProgresso()
        })
        
    }
    
    func incrementProgresso() {
        self.progressValore = sharedData.percentageManager.week.percentage
    }
}

struct ProgressBarWeek: View {
    @EnvironmentObject var sharedData: TaskStore
    @Environment(\.colorScheme) var colorScheme
    @Binding var progress: Float
    @State private var scale: Double = 1
    @State private var timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                .shadow(color: .blue.opacity(0.8), radius: 15)
                .foregroundColor(.blue.opacity(0.3))
                .scaleEffect(scale)
                .onReceive(timer, perform: {_ in
                    withAnimation(.easeInOut(duration: 0.8)){
                        if scale == 1{
                            scale += 0.1
                        }else{
                            scale -= 0.1
                        }
                    }
                })
            Circle()
                .stroke(colorScheme == .light ? .white : .black, lineWidth: 30.0)
            Circle()
                .foregroundColor(colorScheme == .light ? Color(white: 1) : Color(white: 0))
                
            Circle()
                .stroke(lineWidth: 30.0)
                .opacity(1)
                .foregroundColor(Color.black)
            
            Circle()
                .stroke(lineWidth: 30.0)
                .opacity(1)
                .foregroundColor(colorScheme == .light ? Color(white: 0.9) : Color(white: 0.2))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut(duration: 1), value: progress)
            
            Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                .font(.system(size: 50))
                .bold()
            
        }
    }
}
//struct ContentView_Previews5: PreviewProvider {
//    static var previews: some View {
//        WeeklyChart()
//    }
//}
