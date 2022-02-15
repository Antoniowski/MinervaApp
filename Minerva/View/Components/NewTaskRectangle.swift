//
//  NewTaskRectangle.swift
//  Minerva
//
//  Created by Martina Ottaviano on 14/02/22.
//

import Foundation
import SwiftUI

struct NewTaskRectangle: View{
    
    @Binding var isActive: Bool
    @Binding var allTasks: [TaskCD]
    @Binding var date: Date
    
    var body: some View{
        Button(action:{
            isActive.toggle()
        }, label: {
            HStack{
                Text ("Add Task")
                    .foregroundColor(.blue)
            }
            .frame(width: UIScreen.main.bounds.width*0.9, height: 80)
            .background(Color(red: 200/255, green: 200/255, blue: 200/255, opacity: 1))
            .cornerRadius(15)
            .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
            
        })
            .sheet(isPresented: $isActive){
                NewTaskModal(dateActivity: $date, allTasks: $allTasks)
            }
        
    }
}


//struct ContentView2_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskRectangle(isActive:)
//    }
//}
