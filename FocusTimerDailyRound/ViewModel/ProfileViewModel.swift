//
//  ProfileViewModel.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import Foundation
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var totalPoints = 0

    @Published var sessions: [HistoricalSession] = []

    @Published var badges: [Badge] = []
    
    @Published var profileImageData: Data?

    private let storageService: StorageServiceProtocol

    init(
        storageService: StorageServiceProtocol
    ) {

        self.storageService = storageService

        loadData()
    }

    func loadData() {

        let completedPoints = storageService.loadPoints()
        var computedTotalPoints = completedPoints

        sessions = storageService.loadHistory()
        var allBadges = sessions.flatMap { $0.badges }

        if let active = storageService.loadActiveSession() {
            let start = active.1
            let currentElapsed = Date().timeIntervalSince(start)
            let activePoints = Int(currentElapsed / AppConstants.secondsPerPoint)
            computedTotalPoints += activePoints
            
            let badgeService = BadgeService()
            let activeBadges = badgeService.badges(for: activePoints, startingFrom: completedPoints)
            allBadges.append(contentsOf: activeBadges)
        }

        totalPoints = computedTotalPoints
        badges = allBadges.map { Badge(symbolName: $0) }
            
        profileImageData = storageService.loadProfileImage()
    }
    
    func saveProfileImage(_ data: Data) {
        storageService.saveProfileImage(data)
        profileImageData = data
    }
}