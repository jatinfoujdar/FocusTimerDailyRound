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
            .padding(6)
            .background(Color(.systemGray5))
            .clipShape(Circle())
    }
}