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
    
    func saveActiveSession(mode: FocusMode, startTime: Date)
    
    func loadActiveSession() -> (FocusMode, Date)?
    
    func clearActiveSession()
    
    func saveProfileImage(_ data: Data)
    
    func loadProfileImage() -> Data?
}

final class StorageService: StorageServiceProtocol {

    private let historyKey = "history"
    private let pointsKey = "totalPoints"
    private let activeModeKey = "activeSessionMode"
    private let activeStartTimeKey = "activeSessionStartTime"
    private let profileImageKey = "profileImageData"

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
    
    func saveActiveSession(mode: FocusMode, startTime: Date) {
        UserDefaults.standard.set(mode.rawValue, forKey: activeModeKey)
        UserDefaults.standard.set(startTime.timeIntervalSince1970, forKey: activeStartTimeKey)
    }
    
    func loadActiveSession() -> (FocusMode, Date)? {
        guard let modeString = UserDefaults.standard.string(forKey: activeModeKey),
              let mode = FocusMode(rawValue: modeString) else {
            return nil
        }
        let timeInterval = UserDefaults.standard.double(forKey: activeStartTimeKey)
        guard timeInterval > 0 else { return nil }
        return (mode, Date(timeIntervalSince1970: timeInterval))
    }
    
    func clearActiveSession() {
        UserDefaults.standard.removeObject(forKey: activeModeKey)
        UserDefaults.standard.removeObject(forKey: activeStartTimeKey)
    }
    
    func saveProfileImage(_ data: Data) {
        UserDefaults.standard.set(data, forKey: profileImageKey)
    }
    
    func loadProfileImage() -> Data? {
        UserDefaults.standard.data(forKey: profileImageKey)
    }
}
