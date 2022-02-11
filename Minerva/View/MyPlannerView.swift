//
//  MyPlannerView.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct MyPlannerView: View{
    
    @State private var date = Date()
    
    var body: some View{
        ScrollView{
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .accentColor(.purple)
            
            Text("Attività del \(date.formatted(date: .abbreviated, time: .omitted)) ")
            
            ForEach(0...3, id: \.self){ _ in
                TaskRectangle()
            }

        }
    }
}


struct MyPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlannerView()
    }
}


