//
//  ProfileView.swift
//  FocusTimerDailyRound
//
//  Created by jatin foujdar on 11/06/26.
//


import SwiftUI
import Combine
import PhotosUI

struct ProfileView: View {

    @StateObject var vm: ProfileViewModel
    @AppStorage("userName") var userName: String = "Jatin Foujdar"
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .center, spacing: 12) {
                        HStack {
                            Spacer()
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                if let data = vm.profileImageData, let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                                        .shadow(radius: 3)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .foregroundColor(.gray)
                                        .clipShape(Circle())
                                }
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        vm.saveProfileImage(data)
                                    }
                                }
                            }
                            Spacer()
                        }
                        
                        TextField("Name", text: $userName)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 40)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
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
                        let columns = [
                            GridItem(.adaptive(minimum: 60))
                        ]
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(groupedBadges.sorted(by: { $0.key < $1.key }), id: \.key) { symbolName, count in
                                VStack(spacing: 4) {
                                    Image(systemName: symbolName)
                                        .font(.title2)
                                        .foregroundColor(.accentColor)
                                        .frame(width: 44, height: 44)
                                        .background(Color(.systemGray6))
                                        .clipShape(Circle())
                                    Text("x\(count)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .padding(.vertical, 8)
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
                if userName == "App intern" || userName == "App Intern" {
                    userName = "Jatin Foujdar"
                }
            }
        }
    }

    private var groupedBadges: [String: Int] {
        var counts: [String: Int] = [:]
        for badge in vm.badges {
            counts[badge.symbolName, default: 0] += 1
        }
        return counts
    }
}
