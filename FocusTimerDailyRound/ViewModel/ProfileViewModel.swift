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

    @Published var sessions:
    [HistoricalSession] = []

    @Published var badges:
    [Badge] = []

    private let storageService:
    StorageService

    init(
        storageService: StorageService
    ) {

        self.storageService =
        storageService

        loadData()
    }

    func loadData() {

        totalPoints =
        storageService.loadPoints()

        sessions =
        storageService.loadHistory()

        badges =
        sessions
            .flatMap { $0.badges }
            .map { Badge(symbolName: $0) }
    }
}