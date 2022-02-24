//
//  InfoBadges.swift
//  Minerva
//
//  Created by Martina Ottaviano on 24/02/22.
//

import Foundation
import SwiftUI



struct InfoBadges: View{
    @State private var badges: [Image] = [Image("Multitasker"), Image("Trooper"), Image("Social"), Image("Perfectionist")]
    @State var badgesData : Data = .init(count: 0)
    
    var body: some View{
        VStack{
            
            ForEach(0..<badges.count) { imageIdx in  HStack{
                badges[imageIdx]
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/3.5, height:UIScreen.main.bounds.width/3.5)
                VStack{
                Text("Name")
                        .font(.system(size: 20))
                        .bold()
                        .frame(width: UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.width/20, alignment: .leading)
                Text("How to acheve the badge")
                        .frame(width: UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.width/20, alignment: .leading)
                            
                }
                
            }
                Divider()
            }
            
        }
    }
}
struct InfoBadges_Preview: PreviewProvider {
    static var previews: some View {
        InfoBadges()
    }
}



