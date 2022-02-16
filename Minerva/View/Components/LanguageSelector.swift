//
//  LanguageSelector.swift
//  Minerva
//
//  Created by Antonio Romano on 16/02/22.
//

import Foundation
import SwiftUI

struct LanguageSelector: View{
    var language: String
    var body: some View{
        HStack{
            Image(language)
                .resizable()
                .scaledToFit()
        }
        .frame(width: UIScreen.main.bounds.height*0.08, height: UIScreen.main.bounds.height*0.08)
        .clipped()
        .clipShape(Circle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelector(language: "flagItaly")
    }
}
