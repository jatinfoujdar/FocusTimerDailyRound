//
//  HomeView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI

struct HomeView: View {

    @StateObject var vm: HomeViewModel
    let storageService: StorageServiceProtocol
    @Environment(\.scenePhase) private var scenePhase

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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(vm: ProfileViewModel(storageService: storageService))) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    vm.refreshActiveSessionTime()
                }
            }
        }
    }
}