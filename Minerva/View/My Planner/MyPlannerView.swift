//
//  MyPlannerView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MyPlannerView: View{
    
    @EnvironmentObject var sharedData: TaskControllerCD
    
    @State private var allTasks: [TaskCD] = []
    @State private var date = Date()
    @State private var isActive: Bool = false
    @Binding var editStatus: Bool
    
    var body: some View{
        ScrollView{
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .accentColor(.blue)
            
            Text("Activities for \(date.formatted(date: .abbreviated, time: .omitted)) ")
            if editStatus == false{
            ForEach(allTasks, id:\.self){T in
                if T.date_of_activity?.formatted(date: .long, time: .omitted) == date.formatted(date: .long, time: .omitted){
                    TaskRectangle(title: T.title ?? "", description: T.activity_description ?? "", priority: PriorityLevel(rawValue: T.priority!) ?? .low, isCompleted: T.completed,date: T.date_of_activity ?? Date(), allTask: $allTasks, referredTask: T)
                        
                }
            }
            .padding(5)
            
            NewTaskRectangle(isActive: $isActive, allTasks: $allTasks, date: $date)
                .padding(.top, 5)
            
            }else{
                ForEach(allTasks, id:\.self){T in
                    if T.date_of_activity?.formatted(date: .long, time: .omitted) == date.formatted(date: .long, time: .omitted){
                        TaskRectangleEdit(title: T.title ?? "", description: T.activity_description ?? "", priority: PriorityLevel(rawValue: T.priority!) ?? .low, isCompleted: T.completed,date: T.date_of_activity ?? Date(), allTask: $allTasks, referredTask: T)
                    }
                }
                .padding(5)
            }
        }
        .onAppear(perform: {
            allTasks = sharedData.GetAllTaskOrdered()
        })
    }
}
