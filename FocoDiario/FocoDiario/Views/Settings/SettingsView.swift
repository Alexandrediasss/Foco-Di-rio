//
//  SettingsView.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var onDurationChanged: ((Int) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(showEllipsis: false)
            
            HStack {
                Text("Ajustes")
                    .font(.system(size: 34, weight: .bold, design: .default))
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .padding(.bottom, 4)
            
            List {
                Section {
                    HStack(spacing: 14) {
                        Image(systemName: "moon")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                            .frame(width: 28, height: 28)
                            .background(Color(.tertiarySystemFill))
                            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        
                        Toggle("Modo Escuro", isOn: $viewModel.isDarkMode)
                            .font(.system(size: 17, weight: .regular))
                    }
                    .padding(.vertical, 2)
                } footer: {
                    Text("APARÊNCIA DO APLICATIVO")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.top, 4)
                }
                
                Section {
                    Button(action: {
                        withAnimation {
                            viewModel.notificationsEnabled.toggle()
                        }
                    }) {
                        HStack(spacing: 14) {
                            Image(systemName: "bell")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                                .frame(width: 28, height: 28)
                                .background(Color(.tertiarySystemFill))
                                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                            
                            Text("Notificações")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if viewModel.notificationsEnabled {
                                Text("Ativado")
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                            } else {
                                Text("Desativado")
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                            }
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(.tertiaryLabel))
                        }
                        .padding(.vertical, 2)
                    }
                    
                    Button(action: {
                        withAnimation {
                            viewModel.cycleDefaultDuration()
                            onDurationChanged?(viewModel.defaultDurationMinutes)
                        }
                    }) {
                        HStack(spacing: 14) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                                .frame(width: 28, height: 28)
                                .background(Color(.tertiarySystemFill))
                                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                            
                            Text("Duração Padrão")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("\(viewModel.defaultDurationMinutes) min")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(.tertiaryLabel))
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
