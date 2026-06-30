//
//  FocusViewModel.swift
//  FocoDiario
//
//  Created by Carlos Alexandre Dias Messias de Lima on 30/06/26.
//

import SwiftUI
import Combine

class FocusViewModel: ObservableObject {
    @Published private(set) var session: FocusSession
    @Published var objectiveText: String = "" {
        didSet {
            session.objective = objectiveText
        }
    }
    
    private var timerCancellable: AnyCancellable?
    
    init(defaultDurationMinutes: Int = 25) {
        self.session = FocusSession(totalDurationMinutes: defaultDurationMinutes)
    }
    
    var formattedTime: String {
        session.formattedTime
    }
    
    var progress: Double {
        session.progress
    }
    
    var isRunning: Bool {
        session.state == .running
    }
    
    var buttonTitle: String {
        switch session.state {
        case .idle, .paused:
            return "Iniciar"
        case .running:
            return "Pausar"
        }
    }
    
    var buttonIconName: String {
        switch session.state {
        case .idle, .paused:
            return "play.fill"
        case .running:
            return "pause.fill"
        }
    }
    
    func toggleTimer() {
        if session.state == .running {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        guard session.state != .running else { return }
        session.state = .running
        
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func pauseTimer() {
        guard session.state == .running else { return }
        session.state = .paused
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func resetTimer(durationMinutes: Int? = nil) {
        timerCancellable?.cancel()
        timerCancellable = nil
        let minutes = durationMinutes ?? Int(session.totalDuration / 60)
        session = FocusSession(objective: objectiveText, totalDurationMinutes: minutes)
    }
    
    func updateDefaultDuration(_ minutes: Int) {
        if session.state == .idle {
            resetTimer(durationMinutes: minutes)
        }
    }
    
    private func tick() {
        if session.timeRemaining > 0 {
            session.timeRemaining -= 1.0
        } else {
            pauseTimer()
            session.state = .idle
        }
    }
}
