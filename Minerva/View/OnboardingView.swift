//
//  OnboardingView.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            Image(systemName: "moon.stars.fill")
                .foregroundColor(.black)
                .font(.system(size: 70))
                .padding()
            Text("Welcome! This section is still under construction.")
            
            
                .padding()
            Text("Please select preferred language:")
            HStack{
                Button{
                    print ("Hai selezionato Italiano")
                } label: {
                    Text ("🇮🇹")
                        .font(.system(size: 80))
                }
                
                Button{
                    print ("You selected English")
                } label: {
                    Text ("🇬🇧")
                        .font(.system(size: 80))
                }
            }
            
            Button("Continue"){
                dismiss()
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width*0.5, height: 60)
            .background(.blue.opacity(1))
            .cornerRadius(15)
            .shadow(color: .black .opacity(0.5), radius: 3, x: 2, y: 4)
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
