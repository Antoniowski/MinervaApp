//
//  InfoBadges.swift
//  Minerva
//
//  Created by Martina Ottaviano on 24/02/22.
//

import Foundation
import SwiftUI


struct InfoBadges: View{
    @State private var badges: [Badge] = [
        Badge(title: "The Multitasker", description: "Complete 50% or more of weekly tasks", image: "Multitasker"),
        Badge(title: "The Trooper", description: "Complete all daily tasks", image: "Trooper"),
        Badge(title: "The Social", description: "Join a new studying group", image: "Social"),
        Badge(title: "The Perfectionist", description: "Complete all weekly tasks", image: "Perfectionist")]
    
    
    var body: some View{
        //        NavigationView{
        ScrollView{
            VStack{
                
                ForEach(badges, id:\.self) { badge in
                    HStack{
                        Image(badge.image)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width/3.5, height:UIScreen.main.bounds.width/3.5)
                        VStack{
                            Text(LocalizeStrings(badge.title))
                                .font(.system(size: 20))
                                .bold()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Text(LocalizeStrings(badge.description))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        ZStack{
                            Circle()
                                .foregroundColor(taskColor)
                            if badge.title == "The Multitasker"{
                                Text("\(UserDefaults.standard.integer(forKey: "multitaskerTotalQty"))")
                                    .bold()
                            }
                            if badge.title == "The Trooper"{
                                Text("\(UserDefaults.standard.integer(forKey: "trooperTotalQty"))")
                                    .bold()
                            }
                            if badge.title == "The Social"{
                                Text("\(UserDefaults.standard.integer(forKey: "socialTotalQty"))")
                                    .bold()
                            }
                            if badge.title == "The Perfectionist"{
                                Text("\(UserDefaults.standard.integer(forKey: "perfectionistTotalQty"))")
                                    .bold()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width/10)
                        .padding()
                    }
                    Divider()
                }
                
            }
        }
        //        }
    }
}
struct InfoBadges_Preview: PreviewProvider {
    static var previews: some View {
        InfoBadges()
    }
}



