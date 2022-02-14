//
//  TaskRectangle.swift
//  Minerva
//
//  Created by Antonio Romano on 11/02/22.
//

import SwiftUI

struct TaskRectangle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        HStack{
            
            ZStack{
                Image(systemName: "checkmark")
                    .foregroundColor(Color.blue)
                
                    
            }
            .frame(width: UIScreen.main.bounds.width/9, height: 45)
            .background(Color.white)
            .opacity(0.7)
            .cornerRadius(10)
            
            VStack{
                Text ("Math")
                    .font(.custom("Noteworthy-Bold", size: 25))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Text ("Study first part of Chapter 3")
                    .font(.system(size: 18))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            VStack{
                Circle()
                    .frame(width: 10, height: 10)
                Circle()
                    .frame(width: 10, height: 10)
                Circle()
                    .frame(width: 10, height: 10)
            }
            .frame(width: UIScreen.main.bounds.width/10, height: 40)
            
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width*0.9, height: 80)
        .background(colorScheme == .dark ? Color( red: 69/255, green: 74/255, blue: 114/255, opacity: 1) : Color(red: 227/255, green: 224/255, blue: 249/255))
        .cornerRadius(15)
        .shadow(color: .black, radius: 3, x: 2, y: 4)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRectangle()
    }
}
