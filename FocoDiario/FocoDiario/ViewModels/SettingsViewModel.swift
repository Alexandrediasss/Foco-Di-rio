//
//  SettingsViewModel.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published private var settings: AppSettings
    
    let availableDurations = [15, 25, 45, 60]
    
    init(settings: AppSettings = AppSettings()) {
        self.settings = settings
    }
    
    var isDarkMode: Bool {
        get { settings.isDarkMode }
        set {
            objectWillChange.send()
            settings.isDarkMode = newValue
        }
    }
    
    var notificationsEnabled: Bool {
        get { settings.notificationsEnabled }
        set {
            objectWillChange.send()
            settings.notificationsEnabled = newValue
        }
    }
    
    var defaultDurationMinutes: Int {
        get { settings.defaultDurationMinutes }
        set {
            objectWillChange.send()
            settings.defaultDurationMinutes = newValue
        }
    }
    
    func cycleDefaultDuration() {
        if let currentIndex = availableDurations.firstIndex(of: defaultDurationMinutes) {
            let nextIndex = (currentIndex + 1) % availableDurations.count
            defaultDurationMinutes = availableDurations[nextIndex]
        } else {
            defaultDurationMinutes = 25
        }
    }
}
