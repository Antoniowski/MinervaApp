//
//  TeamView.swift
//  Minerva
//
//  Created by Martina Ottaviano on 16/02/22.
//

import Foundation
import SwiftUI

struct TeamView: View {
    @State private var scale: Double = 1
    @State private var timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    var body: some View{
        VStack{
            Image(systemName: "person.3.fill")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width*0.5)
                .foregroundColor(.secondary.opacity(0.5))
                .scaleEffect(scale)
                .onReceive(timer, perform: {_ in
                    withAnimation{
                        if scale == 1{
                            scale += 0.1
                        }else{
                            scale -= 0.1
                        }
                    }
                })
             Text("Group section coming Soon")
                .foregroundColor(.secondary.opacity(0.5))

        }
        
    }
}

struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}
