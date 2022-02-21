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
    var body: some View{
        VStack{
            
            ScrollView{
                WeeklyChart()
                Text("Percentage of tasks completed this week")
                    . frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/10, alignment: .leading)
                Divider()
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0...6, id: \.self){_ in
                            CardComponent()
                        }
                    }.padding(.horizontal, 15)
                    
                    
                }
                .padding(.bottom,6)
                Divider()
                
                Text("Badges")
                    .font(.custom("Noteworthy-Bold", size: 30))
                    . frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.width/11, alignment: .leading)
                
                
                ScrollView(.horizontal){
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
