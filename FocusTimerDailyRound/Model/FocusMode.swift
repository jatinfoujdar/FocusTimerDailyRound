//
//  FocusMode.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//
import SwiftUI


enum FocusMode: String, CaseIterable, Codable {
    case work = "Work"
    case play = "Play"
    case rest = "Rest"
    case sleep = "Sleep"

    var icon: String {
        switch self {
        case .work: return "briefcase.fill"
        case .play: return "gamecontroller.fill"
        case .rest: return "leaf.fill"
        case .sleep: return "moon.fill"
        }
    }
}
