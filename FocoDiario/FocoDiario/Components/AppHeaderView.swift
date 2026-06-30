//
//  AppHeaderView.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI

struct AppHeaderView: View {
    var showEllipsis: Bool = false
    var onEllipsisTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            ConcentricCirclesLogo()
                .frame(width: 24, height: 24)
            
            Text("Foco Diário")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(.primary)
            
            Spacer()
            
            if showEllipsis {
                Button(action: {
                    onEllipsisTapped?()
                }) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.8))
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

struct ConcentricCirclesLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 0.05, green: 0.48, blue: 0.22), lineWidth: 1.8)
            Circle()
                .stroke(Color(red: 0.05, green: 0.48, blue: 0.22), lineWidth: 1.8)
                .padding(3.5)
            Circle()
                .fill(Color(red: 0.05, green: 0.48, blue: 0.22))
                .padding(7.5)
        }
    }
}

#Preview {
    AppHeaderView(showEllipsis: true)
}
