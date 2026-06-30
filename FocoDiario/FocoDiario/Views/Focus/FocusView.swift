//
//  FocusView.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI

struct FocusView: View {
    @ObservedObject var viewModel: FocusViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(showEllipsis: true) {
                // Action for header menu if needed
            }
            
            Spacer(minLength: 20)
            
            // Central highlighted timer circle
            TimerRingView(
                formattedTime: viewModel.formattedTime,
                progress: viewModel.progress,
                isRunning: viewModel.isRunning
            )
            .padding(.bottom, 36)
            
            // Objective highlighted text field below timer
            HStack {
                TextField("Estudando SwiftUI", text: $viewModel.objectiveText)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        isTextFieldFocused = false
                    }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .padding(.horizontal, 40)
            
            Spacer(minLength: 30)
            
            // Floating control buttons in Z-Stack hierarchy
            FocusControlButtonsView(
                title: viewModel.buttonTitle,
                iconName: viewModel.buttonIconName,
                isRunning: viewModel.isRunning,
                action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        viewModel.toggleTimer()
                        isTextFieldFocused = false
                    }
                },
                onReset: {
                    withAnimation {
                        viewModel.resetTimer()
                    }
                }
            )
            .padding(.bottom, 30)
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

#Preview {
    FocusView(viewModel: FocusViewModel())
}
