//
//  ActiveSessionView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI

struct ActiveSessionView: View {

    @ObservedObject
    var vm: HomeViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(vm.activeMode?.rawValue ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(vm.formatTime(vm.elapsedTime))
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .padding()

            HStack {
                Text("Points: \(vm.currentPoints)")
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(vm.badges) { badge in
                            BadgeView(badge: badge)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            Button(action: { vm.stopSession() }) {
                Text("Stop Focusing")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.top)
        }
        .padding()
    }
}