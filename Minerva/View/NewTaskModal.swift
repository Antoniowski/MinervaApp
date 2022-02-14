//
//  NewTaskModal.swift
//  Minerva
//
//  Created by Martina Ottaviano on 14/02/22.
//

import Foundation
import SwiftUI

struct NewTaskModal: View{
    @EnvironmentObject var sharedData: TaskControllerCD
    @Environment(\.dismiss) private var dismiss

    @State private var titleField: String = ""
    @State private var descriptionField: String = ""
    @State private var priorityValue: PriorityLevel = .low
    
    @Binding var allTasks: [TaskCD]
    
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
                    Text("Create new task")
                        .font(.custom("Noteworthy-Bold", size: 25))
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        sharedData.AddTask(title: titleField, description: descriptionField, priority: priorityValue)
                        allTasks = sharedData.GetAllTask()
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                })
            }
        }
    }
    
}

//struct ContentView3_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskModal(allTasks:)
//    }
//}
