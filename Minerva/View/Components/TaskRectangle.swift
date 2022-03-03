//
//  TaskRectangle.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct TaskRectangle: View {
    @EnvironmentObject var sharedData: TaskStore
    
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
//                    Circle()
//                        .frame(width: 10, height: 10)
                    Image(systemName: "3.circle")
                        .font(.system(size: 30))
                }.frame(width: UIScreen.main.bounds.width/10, height: 40)
            }
            
            else if priority == .mid {
                VStack{
//                    Circle()
//                        .frame(width: 10, height: 10)
//                    Circle()
//                        .frame(width: 10, height: 10)
                    Image(systemName: "2.circle")
                        .font(.system(size: 30))
                }
                .frame(width: UIScreen.main.bounds.width/10, height: 40)
            }
            else {
                
                ZStack{
//                    Circle()
//                        .frame(width: 10, height: 10)
//                    Circle()
//                        .frame(width: 10, height: 10)
//                    Circle()
//                        .frame(width: 10, height: 10)
                    
                        Image(systemName: "1.circle")
                            .font(.system(size: 30))
                            //                        Text("3")
//                            .font(.system(size: 19))
//                            .offset(y: 2)
                }
                .frame(width: UIScreen.main.bounds.width/10, height: 40)
            }
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width*0.9, height: 80)
        .background(taskColor)
        .cornerRadius(15)
        .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
    }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRectangle()
//    }
//}
