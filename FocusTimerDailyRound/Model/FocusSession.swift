//
//  FocusSession.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import Foundation

enum FocusMode: String, Codable, CaseIterable, Identifiable {
    case work = "Work"
    case play = "Play"
    case rest = "Rest"
    case sleep = "Sleep"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .work: return "laptopcomputer"
        case .play: return "gamecontroller"
        case .rest: return "bed.double"
        case .sleep: return "moon.stars"
        }
    }
}


struct ActiveSession: Codable {
    let startTime: Date
    let mode: FocusMode
    var earnedBadges: [String]
}


struct HistoricalSession: Codable, Identifiable {
    let id: UUID
    let mode: FocusMode
    let startTime: Date
    let duration: TimeInterval
    let pointsEarned: Int
    let badges: [String]
}


struct UserProfile: Codable {
    var name: String
    var avatarData: Data?
    var totalPoints: Int
    var totalBadges: [String]
}
