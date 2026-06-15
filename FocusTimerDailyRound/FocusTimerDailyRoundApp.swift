//
//  FocusTimerDailyRoundApp.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import SwiftUI


@main
struct FocusTimerApp: App {

    private let storageService: StorageServiceProtocol = StorageService()

    private let timerService =  TimerService()

    private let badgeService =  BadgeService()

    var body: some Scene {
        WindowGroup {
            HomeView(
                vm: HomeViewModel(
                    timerService: timerService,
                    storageService: storageService,
                    badgeService: badgeService
                ),
                storageService: storageService
            )
        }
    }
}
