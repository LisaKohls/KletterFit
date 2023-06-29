//
//  CircularProgressBar.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 08.06.23.
//

import SwiftUI

struct CircularProgressBar: View {
    let title: String
    let value: Double
    let total: Double
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .padding(.bottom, 10)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 12)
                    .opacity(0.2)
                    .foregroundColor(Color.gray)
                
                Circle()
                    .trim(from: 0, to: CGFloat(isAnimating ? value / total : 0))
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                
                Text(String(format: "%.0f %%", self.value * 100))
                    .font(.caption)
                    .bold()
            }
            .onAppear {
                withAnimation(.linear(duration: 1.0)) {
                    self.isAnimating = true
                }
            }
        }
    }
    }

struct CircularProgressBar_Previews: PreviewProvider {
    @State static var progressValue:Float = 0.0
    static var previews: some View {
        ProgressView("Weekly Goal", value: 50, total: 100)
    }
}

