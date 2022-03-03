//
//  TaskRectangleEdit.swift
//  Minerva
//
//  Created by Antonio Romano on 17/02/22.
//

import Foundation
import SwiftUI

struct TaskRectangleEdit: View {
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
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var rotazione: Double = 0
    
    var body: some View {
        Button(action:{
            showOptions = true
        }, label: {
            HStack{
                
                ZStack{
                    if isCompleted == true{
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.blue)
                    }
//                    Button(action: {
//                        isCompleted.toggle()
//                        sharedData.UpdateTask(task: referredTask, isCompleted: isCompleted)
//                    }, label: {
//                        HStack{}
//                        .frame(width: UIScreen.main.bounds.width/9, height: 45)
//                    })
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
                        Image(systemName: "1.circle")
                            .font(.system(size: 30))
//                        Circle()
//                            .frame(width: 10, height: 10)
                    }.frame(width: UIScreen.main.bounds.width/10, height: 40)
                }
                
                else if priority == .mid {
                    VStack{
                        Image(systemName: "2.circle")
                            .font(.system(size: 30))
//                        Circle()
//                            .frame(width: 10, height: 10)
//                        Circle()
//                            .frame(width: 10, height: 10)
                    }
                    .frame(width: UIScreen.main.bounds.width/10, height: 40)
                }
                else {
                    
                    VStack{
                        Image(systemName: "3.circle")
                            .font(.system(size: 30))
//                        Circle()
//                            .frame(width: 10, height: 10)
//                        Circle()
//                            .frame(width: 10, height: 10)
//                        Circle()
//                            .frame(width: 10, height: 10)
                    }
                    .frame(width: UIScreen.main.bounds.width/10, height: 40)
                }
            }
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width*0.9, height: 80)
            .background(colorScheme == .dark ? Color( red: 69/255, green: 74/255, blue: 114/255, opacity: 1) : Color(red: 227/255, green: 224/255, blue: 249/255))
            .cornerRadius(15)
            .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
        })
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .rotationEffect(.degrees(rotazione))
            .onReceive(timer, perform: {_ in
                ShakingAnimation(WithThisAngle: 4)
            })
            .confirmationDialog("", isPresented: $showOptions, titleVisibility: .hidden){
                Button(isCompleted ? "Uncheck" : "Check"){
                    isCompleted.toggle()
                    sharedData.UpdateTask(task: referredTask, isCompleted: isCompleted)
                    withAnimation(.linear(duration: 0.2)){
                        sharedData.FetchOrdered()
                    }
                }
                
                Button("Edit"){
                    showModal.toggle()
                }
                
                Button(role: .destructive, action: {
                    sharedData.DeleteTask(task: referredTask)
                    withAnimation(.linear(duration: 0.2)){
                        sharedData.FetchOrdered()
                    }
                }, label: {
                    Text("Delete")
                })
                
            }
            .sheet(isPresented: $showModal) {
                NewTaskModal(titleField: title, descriptionField: description, priorityValue: priority, isEditing: true, dateActivity: $date, referredTask: referredTask)
            }
        
        
        
    }
    
    private func ShakingAnimation(WithThisAngle valore: Double){
        withAnimation(){
            if self.rotazione == 0{
                self.rotazione += valore
            }else if rotazione == valore{
                self.rotazione -= valore*2
            }else{
                self.rotazione += valore*2
            }
        }
    }
    
}
