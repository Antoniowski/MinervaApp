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
    @State var progressValue: Float = 0.0
    @State var date: Date = Date()
    @State var weekday: String = ""
    
    var body: some View{
        ZStack{
            VStack{
                NewChartComponent(weekday: $weekday)
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                        
                        
                HStack{
                    
                }.frame(width: 100, height: 10)
                
                VStack{
                    Text("\(weekday)")
                        .font(.custom("Noteworthy-Bold", size: 25))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    //                        .border(.blue)
                    
                } . frame(width: UIScreen.main.bounds.width/2.8, height: UIScreen.main.bounds.width/8, alignment: .leading)
                //                    .border(.red)
                
                
            }
        }.frame(width: UIScreen.main.bounds.width/2.4, height: UIScreen.main.bounds.width/1.5)
            .background(colorScheme == .dark ? Color( red: 69/255, green: 74/255, blue: 114/255, opacity: 1) : Color(red: 227/255, green: 224/255, blue: 249/255))
        //            .border(.red)
            .cornerRadius(15)
            .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
            .padding(6)
            
            
        
    }
    
    func GetWeekday(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        return weekday
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardComponent()
    }
}

