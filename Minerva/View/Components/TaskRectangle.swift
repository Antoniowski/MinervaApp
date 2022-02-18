//
//  TaskRectangle.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct TaskRectangle: View {
    @EnvironmentObject var sharedData: TaskStore
    @Environment(\.colorScheme) var colorScheme
    
    @State var title: String = ""
    @State var description: String = ""
    @State var priority: PriorityLevel = .low
    @State var isCompleted: Bool = false
    @State var date = Date()
    @State var showOptions: Bool = false
    @State var showModal: Bool = false
    
    var referredTask: TaskCD
    
    var body: some View {
        HStack{
            
            ZStack{
                if isCompleted == true{
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.blue)
                }
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    isCompleted.toggle()
                    sharedData.UpdateTask(task: referredTask, isCompleted: isCompleted)
                }, label: {
                    HStack{}
                    .frame(width: UIScreen.main.bounds.width/9, height: 45)
                })
            }
            .frame(width: UIScreen.main.bounds.width/9, height: 45)
            .background(Color.white)
            .opacity(0.7)
            .cornerRadius(10)
            
            VStack{
                Text ("\(title)")
                    .font(.custom("Noteworthy-Bold", size: 25))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Text ("\(description)")
                    .font(.system(size: 18))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            
            if priority == .low {
                VStack{
                    Circle()
                        .frame(width: 10, height: 10)
                }.frame(width: UIScreen.main.bounds.width/10, height: 40)
            }
            
            else if priority == .mid {
                VStack{
                    Circle()
                        .frame(width: 10, height: 10)
                    Circle()
                        .frame(width: 10, height: 10)
                }
                .frame(width: UIScreen.main.bounds.width/10, height: 40)
            }
            else {
                
                VStack{
                    Circle()
                        .frame(width: 10, height: 10)
                    Circle()
                        .frame(width: 10, height: 10)
                    Circle()
                        .frame(width: 10, height: 10)
                }
                .frame(width: UIScreen.main.bounds.width/10, height: 40)
            }
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width*0.9, height: 80)
        .background(colorScheme == .dark ? Color( red: 69/255, green: 74/255, blue: 114/255, opacity: 1) : Color(red: 227/255, green: 224/255, blue: 249/255))
        .cornerRadius(15)
        .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
    }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRectangle()
//    }
//}
