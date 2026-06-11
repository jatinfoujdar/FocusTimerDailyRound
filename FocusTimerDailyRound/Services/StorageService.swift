//
//  StorageService.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//

import Foundation

protocol StorageServiceProtocol {

    func saveSession(_ session: HistoricalSession)

    func loadHistory() -> [HistoricalSession]

    func savePoints(_ points: Int)

    func loadPoints() -> Int
}



final class StorageService: StorageServiceProtocol {

    private let historyKey = "history"
    private let pointsKey = "totalPoints"

    func saveSession(_ session: HistoricalSession) {

        var sessions = loadHistory()

        sessions.insert(session, at: 0)

        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }

    func loadHistory() -> [HistoricalSession] {

        guard let data =
            UserDefaults.standard.data(forKey: historyKey)
        else {
            return []
        }

        return (try? JSONDecoder()
            .decode([HistoricalSession].self, from: data))
        ?? []
    }

    func savePoints(_ points: Int) {

        UserDefaults.standard.set(
            points,
            forKey: pointsKey
        )
    }

    func loadPoints() -> Int {

        UserDefaults.standard.integer(
            forKey: pointsKey
        )
    }
}
