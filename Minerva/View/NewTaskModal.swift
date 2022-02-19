//
//  NewTaskModal.swift
//  Minerva
//
//  Created by Martina Ottaviano on 14/02/22.
//

import Foundation
import SwiftUI

struct NewTaskModal: View{
    @EnvironmentObject var sharedData: TaskStore
    @Environment(\.dismiss) private var dismiss
    
    @State var titleField: String = ""
    @State var descriptionField: String = ""
    @State var priorityValue: PriorityLevel = .low
    @State var isEditing: Bool = false
    @Binding var dateActivity: Date
    
    var referredTask: TaskCD = TaskCD()
    
    
    var body: some View{
        NavigationView{
            VStack{
                TextField("Title", text: $titleField)
                    .padding(.horizontal)
                Divider()
                TextField("Description", text: $descriptionField)
                    .padding(.horizontal)
                
                //            Divider()
                
                List{
                    Button(action: {
                        priorityValue = .high
                    }, label: {
                        HStack{
                            Text("High")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            if priorityValue == .high{
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                    
                    Button(action: {
                        priorityValue = .mid
                    }, label: {
                        HStack{
                            Text("Medium")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            if priorityValue == .mid{
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                    
                    Button(action: {
                        priorityValue = .low
                    }, label: {
                        HStack{
                            Text("Low")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            if priorityValue == .low{
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal, content: {
                    if isEditing == false{
                        Text("Create new task")
                            .font(.custom("Noteworthy-Bold", size: 25))
                    }else{
                        Text("Edit task")
                            .font(.custom("Noteworthy-Bold", size: 25))
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        if isEditing == false {
                            sharedData.AddTask(title: titleField, description: descriptionField, priority: priorityValue, date: dateActivity)
                        }
                        else {
                            sharedData.UpdateTask2(task: referredTask, title: titleField, desc: descriptionField, priority: priorityValue)
                        }
                        sharedData.FetchOrdered()
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                })
            }
        }
    }
    
}
