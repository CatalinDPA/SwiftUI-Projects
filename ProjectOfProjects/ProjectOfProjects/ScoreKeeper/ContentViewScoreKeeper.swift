import SwiftUI

struct ContentViewScoreKeeper: View {
    @ObservedObject private var scoreboard = Scoreboard()
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
        .disabled(scoreboard.rounds > 0)
        NavigationStack {
            HStack {
                Text("Player")
                    .frame(maxWidth: .infinity, alignment: .center)
                if !(scoreboard.state == .setup) {
                    Text("Score")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .transition(.move(edge: .trailing))
                }
            }
            .font(.headline)
            
            Text("Rounds left: \(scoreboard.rounds)")
                .opacity(scoreboard.rounds > 0 ? 1 : 0)
                .onChange(of: scoreboard.rounds) {
                    if scoreboard.rounds == 0  {
                        for player in scoreboard.players {
                            player.wins = 0
                        }
                    }
                }
            List {
                ForEach($scoreboard.players, id: \.id) { $player in
                    HStack {
                        HStack {
                            if player.winner {
                                    Image(systemName: "crown.fill")
                                        .foregroundColor(.yellow)
                                        .transition(.move(edge: .leading))
                                }
                            TextField("name", text: $player.name)
                                .padding(4)
                                .id(player.id)
                                .bold()
                            .disabled(scoreboard.state != .setup)
                            Text("Wins: \(player.wins)")
                        }
                        .padding(.leading, 4)
                        .padding(.trailing, 8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(player.color)
                        }
                        if !(scoreboard.state == .setup) {
                            Text("\(player.score)")
                                .frame(width: 30)
                                .transition(.move(edge: .trailing))
                            Stepper(
                                value: $player.score,
                                in: 0...scoreboard.winningPoints) {
                                    Text("\(player.score)")
                                }
                                .labelsHidden()
                                .onChange(of: player.score, {
                                    scoreboard.playerWon()
                                })
                                .transition(.move(edge: .trailing))
                        }
                            
                    }
                }
                .onMove(perform: move)
            }
            .toolbar {
                if scoreboard.state == .setup {
                    Button("Add player", systemImage: "plus") {
                        scoreboard.players.append(Player(name:"", score: 0,winner: false, wins: 0))
                    }
                    EditButton()
                }
            }
            HStack {
                switch scoreboard.state {
                    case .setup:
                        Button("Start game", systemImage: "play.fill") {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                scoreboard.state = .playing
                            }
                            scoreboard.resetScores(to: startingPoints)
                        }
                        .disabled(scoreboard.rounds == 0)
                    case .playing:
                        Button("End game", systemImage: "stop.fill") {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                scoreboard.state = .gameOver
                            }
                            scoreboard.winners()
                        }
                    case .gameOver:
                        Button("New game", systemImage: "arrow.counterclockwise") {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                scoreboard.state = .setup
                                scoreboard.rounds -= 1
                            }
                        }
                }
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.blue)
        }
        .scrollDisabled(scoreboard.players.count < 4)
    }
    func move(from: IndexSet, to: Int) {
        scoreboard.players.move(fromOffsets: from, toOffset: to)
    }
}

/*struct PlayerListView: View {
    @State var scoreboard: Scoreboard
    @Binding var startingPoints: Int
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Player")
                Spacer()
                Text("Score")
            }
            .font(.headline)
            .frame(maxWidth: 240)
            
            Text("Rounds left: \(scoreboard.rounds)")
                .opacity(scoreboard.rounds > 0 ? 1 : 0)
                .onChange(of: scoreboard.rounds) {
                    if scoreboard.rounds == 0  {
                        for player in scoreboard.players {
                            player.wins = 0
                        }
                    }
                }
            List {
                ForEach($scoreboard.players, id: \.id) { $player in
                    HStack {
                        HStack {
                            if player.winner {
                                    Image(systemName: "crown.fill")
                                        .foregroundColor(.yellow)
                                }
                            TextField("name", text: $player.name)
                                .padding(4)
                                .id(player.id)
                                .bold()
                            .disabled(scoreboard.state != .setup)
                            Text("Wins: \(player.wins)")
                        }
                        .padding(.leading, 4)
                        .padding(.trailing, 8)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(player.color)
                        }

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
                        .onChange(of: player.score, {
                            scoreboard.playerWon()
                        })
                    }
                }
                .onMove(perform: move)
            }
            .toolbar {
                if scoreboard.state == .setup {
                    Button("Add player", systemImage: "plus") {
                        scoreboard.players.append(Player(name:"", score: 0,winner: false, wins: 0))
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
                        .disabled(scoreboard.rounds == 0)
                    case .playing:
                        Button("End game", systemImage: "stop.fill") {
                            scoreboard.state = .gameOver
                            scoreboard.winners()
                        }
                    case .gameOver:
                        Button("New game", systemImage: "arrow.counterclockwise") {
                            scoreboard.state = .setup
                            scoreboard.rounds -= 1
                        }
                }
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.blue)
        }
        .scrollDisabled(scoreboard.players.count < 4)
    }
    func move(from: IndexSet, to: Int) {
        scoreboard.players.move(fromOffsets: from, toOffset: to)
    }
}*/

#Preview {
    ContentViewScoreKeeper()
}
