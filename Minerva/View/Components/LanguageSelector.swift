//
//  LanguageSelector.swift
//  Minerva
//
//  Created by Antonio Romano on 16/02/22.
//

import Foundation
import SwiftUI

struct LanguageSelector: View{
    @Binding var isSelected: Bool
    var language: String
    var body: some View{
        ZStack{
            Image(language)
                .resizable()
                .frame(width: UIScreen.main.bounds.height*0.08, height: UIScreen.main.bounds.height*0.08)
                .clipped()
                .clipShape(Circle())
                .scaledToFit()
            if isSelected{
                Circle()
                    .stroke(.blue, lineWidth: 4)
                    .frame(width: UIScreen.main.bounds.height*0.09, height: UIScreen.main.bounds.height*0.09)
            }
        }
        
    }
}
