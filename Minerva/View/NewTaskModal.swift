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
    
    @State private var titleField: String = ""
    @State private var descriptionField: String = ""
    
    var body: some View{
        VStack{
            
            TextField("Title", text: $titleField)
                .padding(.horizontal)
            Divider()
            TextField("Description", text: $descriptionField)
                .padding(.horizontal)
            
                
            //            Divider()
            List{
                Button(action: {}, label: {
                    HStack{
                        Text("High")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "checkmark")
                            
                    }
                })
                
                Button(action: {}, label: {
                    Text("Medium")
                })
                Button(action: {}, label: {
                    Text("Low")
                })
                
                
            }
            
        }
        
    }
    
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskModal()
    }
}
