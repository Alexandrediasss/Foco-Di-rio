//
//  TimerRingView.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI

struct TimerRingView: View {
    let formattedTime: String
    let progress: Double
    let isRunning: Bool
    
    // Exact forest green from design (#0C6E33)
    private let ringColor = Color(red: 0.05, green: 0.45, blue: 0.20)
    private let ringBackground = Color(red: 0.05, green: 0.45, blue: 0.20).opacity(0.15)
    
    var body: some View {
        ZStack {
            // Background ring track
            Circle()
                .stroke(ringBackground, lineWidth: 6)
            
            // Active countdown ring or full prominent circle
            if isRunning && progress > 0 {
                Circle()
                    .trim(from: 0, to: CGFloat(1.0 - progress))
                    .stroke(
                        ringColor,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1.0), value: progress)
            } else {
                Circle()
                    .stroke(ringColor, lineWidth: 6)
            }
            
            // Monospaced SF font to prevent digit jumping during countdown
            Text(formattedTime)
                .font(.system(size: 72, weight: .regular, design: .monospaced))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
        }
        .frame(width: 280, height: 280)
    }
}

#Preview {
    TimerRingView(formattedTime: "25:00", progress: 0.0, isRunning: false)
}
