//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Catalin Posedaru on 17/11/25.
//

import SwiftUI

struct SettingsViewScoreKeeper: View {
    @Binding var startingPoints: Int
    @Binding var doesHighestScoreWin: Bool
    @Binding var winningPoints: Int
    @Binding var rounds: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Game Rules")
                .font(.headline)
            Divider()
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest score wins")
                    .tag(true)
                Text("Lowest score wins")
                    .tag(false)
            }
            Text("Starting points")
            Picker("Starting points", selection: $startingPoints) {
                Text("0 starting points")
                    .tag(0)
                Text("10 starting points")
                    .tag(10)
                Text("20 starting points")
                    .tag(20)
            }
            Text("Points to win")
            Picker("Points to win", selection: $winningPoints) {
                Text("5 points")
                    .tag(5)
                Text("10 points")
                    .tag(10)
                Text("20 points")
                    .tag(20)
                Text("30 points")
                    .tag(30)
                Text("40 points")
                    .tag(40)
            }
            Text("Total rounds")
            Picker("Total rounds", selection: $rounds) {
                Text("Select one")
                    .tag(0)
                Text("1 round")
                    .tag(1)
                Text("2 rounds")
                    .tag(2)
                Text("3 rounds")
                    .tag(3)
                Text("4 rounds")
                    .tag(4)
                Text("5 rounds")
                    .tag(5)
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
}

