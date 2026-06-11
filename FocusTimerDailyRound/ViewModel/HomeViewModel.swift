//
//  HomeViewModel.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var activeMode: FocusMode?
    @Published var elapsedTime: TimeInterval = 0
    @Published var currentPoints = 0
    @Published var badges: [Badge] = []

    private var startDate: Date?

    private let timerService: TimerService
    private let storageService: StorageService
    private let badgeService: BadgeService

    private var cancellables = Set<AnyCancellable>()

    init(
        timerService: TimerService,
        storageService: StorageService,
        badgeService: BadgeService
    ) {

        self.timerService = timerService
        self.storageService = storageService
        self.badgeService = badgeService

        timerService.$elapsedTime
            .sink { [weak self] value in

                self?.elapsedTime = value

                let points =
                Int(value / AppConstants.secondsPerPoint)

                self?.currentPoints = points

                self?.badges =
                self?.badgeService
                    .badges(for: points)
                    .map { Badge(symbolName: $0) }
                ?? []
            }
            .store(in: &cancellables)
    }

    func startSession(mode: FocusMode) {

        activeMode = mode

        startDate = Date()

        elapsedTime = 0

        currentPoints = 0

        timerService.start(from: startDate!)
    }

    func stopSession() {

        guard let startDate,
              let activeMode
        else { return }

        let session = HistoricalSession(
            id: UUID(),
            mode: activeMode,
            startTime: startDate,
            duration: elapsedTime,
            pointsEarned: currentPoints,
            badges: badges.map(\.symbolName)
        )

        storageService.saveSession(session)

        let total =
        storageService.loadPoints()
        + currentPoints

        storageService.savePoints(total)

        timerService.stop()

        self.activeMode = nil

        elapsedTime = 0

        currentPoints = 0

        badges = []
    }

    func formatTime(
        _ elapsed: TimeInterval
    ) -> String {

        let totalSeconds = Int(elapsed)

        let hours = totalSeconds / 3600

        let minutes =
        (totalSeconds % 3600) / 60

        let seconds =
        totalSeconds % 60

        if hours > 0 {

            return String(
                format: "%02d:%02d:%02d",
                hours,
                minutes,
                seconds
            )
        }

        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
}