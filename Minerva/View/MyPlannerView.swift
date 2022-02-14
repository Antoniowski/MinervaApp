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
    var body: some View{
        ScrollView{
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .accentColor(.blue)
            
            Text("Activities for \(date.formatted(date: .abbreviated, time: .omitted)) ")
            
            ForEach(allTasks, id: \.self){ T in
                TaskRectangle(title: T.title ?? "", description: T.activity_description ?? "", priority: PriorityLevel(rawValue: T.priority!) ?? .low, isCompleted: T.completed)
            }
            .padding(5)

            NewTaskRectangle(isActive: $isActive, allTasks: $allTasks)
                .padding(.top, 5)

        }
        .onAppear(perform: {
            updateTask()
        })
    }
}

//FUNZIONI

extension MyPlannerView{
    func updateTask(){
        allTasks = sharedData.GetAllTask()
    }
}


struct MyPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlannerView()
    }
}


