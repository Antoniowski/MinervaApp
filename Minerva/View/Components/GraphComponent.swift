//
//  GraphComponent.swift
//  Minerva
//
//  Created by Martina Ottaviano on 18/02/22.
//

import Foundation
import SwiftUI

struct PieSliceView: View {
    var pieSliceData = PieSliceData(startAngle: .degrees(0), endAngle: .degrees(180), color: .blue)
    var innerRadius = UIScreen.main.bounds.width*0.7
    var body: some View {
        
        ZStack{
            
            
            Path { path in
                let width: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
                let height = width
                
                let center = CGPoint(x: width * 0.5, y: height * 0.5)
                
                path.move(to: center)
                
                path.addArc(
                    center: center,
                    radius: width * 0.5,
                    startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                    endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                    clockwise: false)
                
            }
            .fill(pieSliceData.color)
            Circle()
                .fill(.white)
                .frame(width: innerRadius, height: innerRadius)
            Text("50%")
                .font(.system(size: 60))
                .bold()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
    }
}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
}

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieSliceView()
    }
}
