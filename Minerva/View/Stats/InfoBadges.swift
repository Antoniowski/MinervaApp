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
        Badge(title: "The Multitasker", description: "Complete 50% or more of daily tasks", image: "Multitasker"),
        Badge(title: "The Trooper", description: "Complete all daily tasks", image: "Trooper"),
        Badge(title: "The Social", description: "Join a new studying group", image: "Social"),
        Badge(title: "The Pefectionist", description: "Complete all weekly tasks", image: "Perfectionist")]
    
    
    var body: some View{
//        NavigationView{
            ScrollView{
                VStack{
                    
                    ForEach(badges, id:\.self) { badge in  HStack{
                        Image(badge.image)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width/3.5, height:UIScreen.main.bounds.width/3.5)
                        VStack{
                            Text(badge.title)
                                .font(.system(size: 20))
                                .bold()
                                .frame(width: UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.width/20, alignment: .leading)
                            Text(badge.description)
                                .frame(width: UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.width/8, alignment: .leading)
                                .foregroundColor(.black .opacity(0.8))
                            
                            
                        }
                        
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



