//
//  BadgeService.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import Foundation

final class BadgeService {

    func badges(for points: Int) -> [String] {

        (0..<points).map {
            AppConstants.badgePool[
                $0 % AppConstants.badgePool.count
            ]
        }
    }
}
