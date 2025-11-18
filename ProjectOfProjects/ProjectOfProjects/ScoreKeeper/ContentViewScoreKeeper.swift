//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Catalin Posedaru on 10/11/25.
//

import SwiftUI

struct ContentViewScoreKeeper: View {
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0
    
    var body: some View {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
        SettingsViewScoreKeeper(
            startingPoints: $startingPoints,
            doesHighestScoreWin: $scoreboard
                .doesHighestScoreWin, winningPoints: $scoreboard.winningPoints, rounds: $scoreboard.rounds)
        .disabled(scoreboard.state != .setup)
            
        NavigationStack {
            HStack {
                Text("Player")
                Spacer()
                Text("Score")
            }
            .font(.headline)
            .frame(maxWidth: 180)
            List {
                ForEach($scoreboard.players) { $player in
                    HStack {
                        HStack {
                            if scoreboard.winners.contains(player) {
                                withAnimation (.easeIn(duration: 2)) {
                                    Image(systemName: "crown.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            TextField("name", text: $player.name)
                                .padding(4)
                                .id(player.id)
                                .bold()
                            .disabled(scoreboard.state != .setup)
                        }
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(player.color)
                        }
                        Text("Wins \(scoreboard.winners.contains(player) ? player.wins+1 : player.wins)")
                        Text("\(player.score)")
                            .frame(width: 30)
                            .opacity(scoreboard.state == .setup ? 0 : 1.0)
                        Stepper(
                            value: $player.score,
                            in: 0...scoreboard.winningPoints) {
                            Text("\(player.score)")
                        }
                        .labelsHidden()
                        .opacity(scoreboard.state == .setup ? 0 : 1.0)
                    }
                }
                .onMove(perform: move)
            }
            .toolbar {
                if scoreboard.state == .setup {
                    Button("Add player", systemImage: "plus") {
                        scoreboard.players.append(Player(name:"", score: 0, wins: 0))
                    }
                    EditButton()
                }
            }
            HStack {
                switch scoreboard.state {
                    case .setup:
                        Button("Start game", systemImage: "play.fill") {
                            scoreboard.state = .playing
                            scoreboard.resetScores(to: startingPoints)
                        }
                    case .playing:
                        Button("End game", systemImage: "stop.fill") {
                            scoreboard.state = .gameOver
                        }
                    case .gameOver:
                        Button("New game", systemImage: "arrow.counterclockwise") {
                            scoreboard.state = .setup
                        }
                }
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.blue)
        }
        
    }
    
    func move(from: IndexSet, to: Int) {
        scoreboard.players.move(fromOffsets: from, toOffset: to)
    }
}

#Preview {
    ContentViewScoreKeeper()
}
