//
//  TimerService.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import Foundation

final class TimerService: ObservableObject {

    @Published var elapsedTime: TimeInterval = 0

    private var timer: Timer?

    func start(from startDate: Date) {

        stop()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in

            self?.elapsedTime =
                Date().timeIntervalSince(startDate)
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
