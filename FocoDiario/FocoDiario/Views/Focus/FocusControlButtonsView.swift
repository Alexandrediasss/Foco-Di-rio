//
//  FocusControlButtonsView.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI

struct FocusControlButtonsView: View {
    let title: String
    let iconName: String
    let isRunning: Bool
    let action: () -> Void
    var onReset: (() -> Void)? = nil
    
    // Pastel green background from HIG prompt
    private let pastelGreen = Color(red: 0.55, green: 0.95, blue: 0.65)
    private let pastelYellow = Color(red: 0.98, green: 0.85, blue: 0.55)
    private let darkGreenText = Color(red: 0.04, green: 0.38, blue: 0.18)
    private let darkBrownText = Color(red: 0.45, green: 0.28, blue: 0.05)
    
    var body: some View {
        ZStack {
            // Z-stack floating hierarchy with subtle pastel glow
            Capsule()
                .fill(isRunning ? pastelYellow : pastelGreen)
                .frame(height: 56)
                .shadow(
                    color: (isRunning ? pastelYellow : pastelGreen).opacity(0.4),
                    radius: 16,
                    x: 0,
                    y: 8
                )
            
            HStack(spacing: 8) {
                Image(systemName: iconName)
                    .font(.system(size: 18, weight: .semibold))
                
                Text(title)
                    .font(.system(size: 18, weight: .semibold, design: .default))
            }
            .foregroundColor(isRunning ? darkBrownText : darkGreenText)
            
            // Invisible button covering the capsule for clean touch target
            Button(action: action) {
                Color.clear
            }
        }
        .frame(width: 220, height: 56)
        .overlay(alignment: .trailing) {
            if isRunning || title == "Pausar" {
                Button(action: {
                    onReset?()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Circle())
                }
                .offset(x: 54)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.75), value: isRunning)
    }
}

#Preview {
    VStack(spacing: 30) {
        FocusControlButtonsView(title: "Iniciar", iconName: "play.fill", isRunning: false, action: {})
        FocusControlButtonsView(title: "Pausar", iconName: "pause.fill", isRunning: true, action: {})
    }
    .padding()
}
