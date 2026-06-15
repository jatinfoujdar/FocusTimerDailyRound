//
//  AppConstants.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import Foundation

enum AppConstants {

    static let secondsPerPoint: TimeInterval = 120
    static let hourThreshold: TimeInterval = 3600 // Can be lowered for testing (e.g. 5 seconds)

    static let badgePool = [
        "tree.fill",
        "leaf.fill",
        "sprout.fill",
        "tortoise.fill",
        "hare.fill",
        "ladybug.fill",
        "bird.fill",
        "ant.fill"
    ]
}
