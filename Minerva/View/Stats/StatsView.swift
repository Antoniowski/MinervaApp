//
//  StatsView.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

struct StatsView: View {
    @EnvironmentObject var sharedData: TaskStore
    let weekdays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var body: some View{
        VStack{
            
            ScrollView{
                WeeklyChart()
                Text("Percentage of tasks completed this week")
                    . frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/10, alignment: .leading)
                Divider()
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(weekdays, id: \.self){weekday in
                            CardComponent(weekday: weekday)
                        }
                    }.padding(.horizontal, 15)
                    
                    
                }
                .padding(.bottom,6)
                Divider()
                
                HStack{
                    Text("Badges")
                    .font(.custom("Noteworthy-Bold", size: 30))
                    . frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/11, alignment: .leading)
                    
                    Button (action: {
                        print("Pagina Info Badges")
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        VStack{
                            Image("BadgeProva")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
                                .scaledToFit()
                            Text("The Perfectionist")
                                .font(.system(size: 10))
                        }
                        
                        VStack{
                            Image("BadgeProva")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
                                .scaledToFit()
                            Text("The Perfectionist")
                                .font(.system(size: 10))
                        }
                        
                        VStack{
                            Image("BadgeProva")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
                                .scaledToFit()
                            Text("The Perfectionist")
                                .font(.system(size: 10))
                        }
                        
                        VStack{
                            Image("BadgeProva")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .leading)
                                .scaledToFit()
                            Text("The Perfectionist")
                                .font(.system(size: 10))
                        }
                        
                        
                    }.padding(.horizontal, 30)
                }
            }
            
        }
    }
}
//struct ContentView_Previews4: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}
