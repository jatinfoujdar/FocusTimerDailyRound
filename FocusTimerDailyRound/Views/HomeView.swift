//
//  HomeView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI

struct HomeView: View {

    @StateObject var vm:
    HomeViewModel

    var body: some View {

        NavigationStack {

            Group {

                if vm.activeMode != nil {

                    ActiveSessionView(
                        vm: vm
                    )

                } else {

                    ModeSelectionView {

                        vm.startSession(
                            mode: $0
                        )
                    }
                }
            }
            .navigationTitle(
                "Focus Timer"
            )
        }
    }
}