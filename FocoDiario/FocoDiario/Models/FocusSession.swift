//
//  FocusSession.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import Foundation

enum FocusTimerState {
    case idle
    case running
    case paused
}

struct FocusSession {
    var objective: String
    var totalDuration: TimeInterval
    var timeRemaining: TimeInterval
    var state: FocusTimerState
    
    init(objective: String = "", totalDurationMinutes: Int = 25) {
        self.objective = objective
        self.totalDuration = TimeInterval(totalDurationMinutes * 60)
        self.timeRemaining = self.totalDuration
        self.state = .idle
    }
    
    var progress: Double {
        guard totalDuration > 0 else { return 0 }
        return 1.0 - (timeRemaining / totalDuration)
    }
    
    var formattedTime: String {
        let totalSeconds = Int(ceil(timeRemaining))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
