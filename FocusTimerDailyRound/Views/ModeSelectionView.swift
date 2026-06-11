//
//  ModeSelectionView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI

struct ModeSelectionView: View {

    let onSelect: (FocusMode) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Choose a Focus Mode")
                .font(.title2)
                .fontWeight(.semibold)

            ForEach(FocusMode.allCases, id: \.self) { mode in
                Button(action: { onSelect(mode) }) {
                    Text(mode.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
    }
}