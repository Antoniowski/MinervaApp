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
            
            Text("Attività del giorno: \(date.formatted(date: .abbreviated, time: .omitted)) ")
            
            
        }
    }
}


struct MyPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlannerView()
    }
}


