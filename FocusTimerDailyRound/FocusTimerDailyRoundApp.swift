//
//  FocusTimerDailyRoundApp.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import SwiftUI


@main
struct FocusTimerApp: App {

    private let storageService = StorageService()

    private let timerService =  TimerService()

    private let badgeService =  BadgeService()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(
                    vm: HomeViewModel(
                        timerService: timerService,
                        storageService: storageService,
                        badgeService: badgeService
                    )
                )
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house"
                    )
                }
                ProfileView(
                    vm: ProfileViewModel(
                        storageService: storageService
                    )
                )
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "person"
                    )
                }
            }
        }
    }
}
