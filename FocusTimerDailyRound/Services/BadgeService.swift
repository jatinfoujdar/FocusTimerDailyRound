//
//  BadgeService.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import Foundation

final class BadgeService {

    let categories: [[String]] = [
        ["tree.fill", "tree", "sprout.fill", "sprout", "globe.americas.fill"], // Trees
        ["leaf.fill", "leaf", "drop.fill", "sparkles", "wind"],                // Leaves & fungi
        ["tortoise.fill", "hare.fill", "ladybug.fill", "bird.fill", "ant.fill"] // Animals
    ]

    func badge(forPointIndex index: Int) -> String {
        // Simple deterministic hash to simulate a random selection
        let seed = (index * 2654435761) ^ 0xDEADBEEF
        let categoryIndex = abs(seed) % categories.count
        let items = categories[categoryIndex]
        
        let itemSeed = (seed &* 1103515245 &+ 12345)
        let itemIndex = abs(itemSeed) % items.count
        
        return items[itemIndex]
    }

    func badges(for points: Int, startingFrom totalPointsBefore: Int) -> [String] {
        (0..<points).map { i in
            badge(forPointIndex: totalPointsBefore + i + 1)
        }
    }
}
