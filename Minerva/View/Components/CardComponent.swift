//
//  CardComponent.swift
//  Minerva
//
//  Created by Martina Ottaviano on 18/02/22.
//

import Foundation
import SwiftUI

struct CardComponent: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        ZStack{
            VStack{
                Circle()
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4.5, alignment: .leading)
                //                    .border(.green)
                
                
                VStack{
                    Text("Monday")
                        .font(.custom("Noteworthy-Bold", size: 24))
                    //                        .border(.blue)
                    Text("Exercise...")
                    Text("Complete...")
                } . frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/8, alignment: .leading)
                //                    .border(.red)
                
                
            }
        }.frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/2)
            .background(colorScheme == .dark ? Color( red: 69/255, green: 74/255, blue: 114/255, opacity: 1) : Color(red: 227/255, green: 224/255, blue: 249/255))
        //            .border(.red)
            .cornerRadius(15)
            .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardComponent()
    }
}

