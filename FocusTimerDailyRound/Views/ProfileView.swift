//
//  ProfileView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI
import Combine

struct ProfileView: View {

    @StateObject var vm: ProfileViewModel
    @AppStorage("userName") var userName: String = "Jatin Foujdar"

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Profile")) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)

                        TextField("Name", text: $userName)
                            .font(.headline)
                    }
                }

                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Total Points")
                        Spacer()
                        Text("\(vm.totalPoints)").fontWeight(.bold)
                    }
                    HStack {
                        Text("Total Badges")
                        Spacer()
                        Text("\(vm.badges.count)").fontWeight(.bold)
                    }
                }

                if !vm.badges.isEmpty {
                    Section(header: Text("Badge Inventory")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(vm.badges) { badge in
                                    BadgeView(badge: badge)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                Section(header: Text("Recent Sessions")) {
                    ForEach(vm.sessions) { session in
                        SessionCardView(session: session)
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                vm.loadData()
            }
        }
    }
}
