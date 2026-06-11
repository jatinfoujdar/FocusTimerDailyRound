//
//  HistoricalSession.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import SwiftUI

struct HistoricalSession: Codable, Identifiable {
    let id: UUID
    let mode: FocusMode
    let startTime: Date
    let duration: TimeInterval
    let pointsEarned: Int
    let badges: [String]
}
