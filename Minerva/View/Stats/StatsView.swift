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
    @State private var badges: [Badge] = [
        Badge(title: "The Multitasker", description: "Complete 50% or more of daily tasks", image: "Multitasker"),
        Badge(title: "The Trooper", description: "Complete all daily tasks", image: "Trooper"),
        Badge(title: "The Social", description: "Join a new studying group", image: "Social"),
        Badge(title: "The Perfectionist", description: "Complete all weekly tasks", image: "Perfectionist")]
    var body: some View{
        VStack{
            
            ScrollView{
                WeeklyChart()
                Text("Percentage of tasks completed this week")
                    . frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/10, alignment: .center)
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
                        NavigationLink(destination: InfoBadges()){
                            Image(systemName: "info.circle")
                        }
                        
                    })
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(badges, id:\.self) { badge in  HStack{
                            VStack{
                                ZStack{
                                    Image(badge.image)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width/3.5, height:UIScreen.main.bounds.width/3.5)
                                    if badge.title == "The Multitasker"{
                                        if UserDefaults.standard.bool(forKey: "multitaskerIsDone") == false{
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.7))
                                                Image(systemName: "lock.fill")
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width: UIScreen.main.bounds.width/4.5, height:UIScreen.main.bounds.width/4.5, alignment: .center)
                                        }
                                    }
                                    if badge.title == "The Trooper"{
                                        if UserDefaults.standard.bool(forKey: "trooperIsDone") == false{
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.7))
                                                Image(systemName: "lock.fill")
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width: UIScreen.main.bounds.width/4.5, height:UIScreen.main.bounds.width/4.5, alignment: .center)
                                        }
                                    }
                                    if badge.title == "The Social"{
                                        if UserDefaults.standard.bool(forKey: "socialIsDone") == false{
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.7))
                                                Image(systemName: "lock.fill")
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width: UIScreen.main.bounds.width/4.5, height:UIScreen.main.bounds.width/4.5, alignment: .center)
                                        }
                                    }
                                    if badge.title == "The Perfectionist"{
                                        if UserDefaults.standard.bool(forKey: "perfectIsDone") == false{
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.7))
                                                Image(systemName: "lock.fill")
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width: UIScreen.main.bounds.width/4.5, height:UIScreen.main.bounds.width/4.5, alignment: .center)
                                        }
                                    }
                                }
                                Text(LocalizeStrings(badge.title))
                                    .font(.system(size: 11))
                            }
                        }
                        }
                        
                    }
                    
                }.padding(.horizontal, 30)
            }
        }
        
    }
}

//struct ContentView_Previews4: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}
