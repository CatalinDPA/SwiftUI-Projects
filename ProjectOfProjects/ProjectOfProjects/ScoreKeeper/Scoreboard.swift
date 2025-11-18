//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Catalin Posedaru on 17/11/25.
//

import Foundation
import SwiftUI

struct Scoreboard {
    var players: [Player] = [
        Player(name: "Cristiano", score: 0, wins: 0),
        Player(name: "Messi", score: 0, wins: 0),
        Player(name: "Pedri", score: 0, wins: 0)
    ]
    
    var state = GameState.setup
    var doesHighestScoreWin = true
    var winningPoints = 0
    var rounds = 1
    var roundWinners: [Player] = []
    
    func playerWon() -> Player? {
        guard state == .playing else {return nil}
        for player in players {
            if player.score == winningPoints && winningPoints != 0 {
                return player
            }
        }
        return nil
    }
    
    
    var winners: [Player] {
        guard state == .gameOver else {return []}
        var winningScore = 0
        
        if doesHighestScoreWin {
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
            return players.filter { player in
                player.score == winningScore
            }
        }    
    mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
