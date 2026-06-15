//
//  BadgeView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI

struct BadgeView: View {

    let badge: Badge

    var body: some View {
        Image(systemName: badge.symbolName)
            .font(.title2)
            .foregroundColor(.accentColor)
            .padding(8)
            .background(Color(.systemGray6))
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}