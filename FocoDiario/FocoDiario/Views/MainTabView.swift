//
//  MainTabView.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var focusViewModel = FocusViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    // Forest green tint matching design HIG
    private let activeGreenTint = Color(red: 0.05, green: 0.45, blue: 0.20)
    
    var body: some View {
        TabView {
            FocusView(viewModel: focusViewModel)
                .tabItem {
                    Label("Focus", systemImage: "clock")
                }
            
            SettingsView(viewModel: settingsViewModel) { newDuration in
                focusViewModel.updateDefaultDuration(newDuration)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .tint(activeGreenTint)
        .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainTabView()
}
