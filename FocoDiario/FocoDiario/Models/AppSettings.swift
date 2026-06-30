//
//  AppSettings.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import Foundation

struct AppSettings {
    var isDarkMode: Bool
    var notificationsEnabled: Bool
    var defaultDurationMinutes: Int
    
    init(isDarkMode: Bool = false, notificationsEnabled: Bool = true, defaultDurationMinutes: Int = 25) {
        self.isDarkMode = isDarkMode
        self.notificationsEnabled = notificationsEnabled
        self.defaultDurationMinutes = defaultDurationMinutes
    }
}
