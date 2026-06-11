//
//  SessionCardView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI

struct SessionCardView: View {

    let session: HistoricalSession

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(session.mode.rawValue)
                    .fontWeight(.bold)

                Text(
                    session.startTime.formatted(
                        date: .abbreviated,
                        time: .shortened
                    )
                )
                .font(.caption)
                .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(formatTime(session.duration))
                Text("+\(session.pointsEarned) pts")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
    }

    private func formatTime(_ elapsed: TimeInterval) -> String {
        let totalSeconds = Int(elapsed)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}