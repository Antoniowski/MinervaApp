//
//  OnboardingView.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    @State private var italySelected: Bool = false
    @State private var englishSelected: Bool = false
    
    var body: some View {
        ZStack{
            Image(colorScheme == .light ? "Pencils" : "DarkPencils")
                .offset(x:UIScreen.main.bounds.width/2.25, y:UIScreen.main.bounds.width/3.3)
            VStack{
                Image("BlockNote")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.25, height: UIScreen.main.bounds.width*0.25)
                    .scaledToFit()
                
                
                Text("Welcome to Minerva")
                    .font(.custom("Noteworthy-Bold", size: 28))
                    .foregroundColor(Color(red: 178/255, green: 155/255, blue: 207/255))
                    .padding(.bottom)
                
                VStack{
                    Text("Daily Planner")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Here goes the content")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .padding(.bottom)
                    
                    Text("Team Creation")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Here goes the content")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .padding(.bottom)
                    
                    Text("Productivity Statistics")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Here goes the content")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width*0.65, height: UIScreen.main.bounds.width*0.4, alignment: .leading)
                
                
                
                Text("Please select preferred language:")
                    .frame(height: 20)
                    .padding(.vertical, 30)
                
                HStack(alignment: .top , spacing: UIScreen.main.bounds.width/12){
                    Button{
                        italySelected = true
                        englishSelected = false
                        print ("Hai selezionato Italiano")
                    } label: {
                        LanguageSelector(isSelected: $italySelected, language: "flagItaly")
                    }
                    
                    Button{
                        englishSelected = true
                        italySelected = false
                        print ("You selected English")
                    } label: {
                        LanguageSelector(isSelected: $englishSelected, language: "flagUK")
                    }
                }
                HStack{}.frame(minHeight: 0, maxHeight: .infinity)

                Button("Continue"){
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    dismiss()
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width*0.9, height: 45)
                .background(.blue.opacity(1))
                .cornerRadius(15)
                //            .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
            }
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
