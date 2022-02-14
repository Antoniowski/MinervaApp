//
//  MyPlannerView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MyPlannerView: View{
    
    @EnvironmentObject var sharedData: TaskControllerCD
    
    @State private var date = Date()
    @State private var isActive: Bool = false
    var body: some View{
        ScrollView{
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .accentColor(.blue)
            
            Text("Activities for \(date.formatted(date: .abbreviated, time: .omitted)) ")
            
            ForEach(0...2, id: \.self){ _ in
                TaskRectangle()
            }
            .padding(5)

            NewTaskRectangle(isActive: $isActive)
                .padding(.top, 5)

        }
    }
}


struct MyPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlannerView()
    }
}


