//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Catalin Posedaru on 17/11/25.
//

import Foundation
import SwiftUI
internal import Combine

class Scoreboard: ObservableObject {

    @Published var players: [Player] = [
        Player(name: "Cristiano", score: 0,winner: false, wins: 0),
        Player(name: "Messi", score: 0,winner: false, wins: 0),
        Player(name: "Pedri", score: 0,winner: false, wins: 0)
    ]
    
    @Published var state = GameState.setup
    @Published var doesHighestScoreWin = true
    @Published var winningPoints = 5
    @Published var rounds = 0
    @Published var roundWinners: [Player] = []
    //Diferencias:
    //Published -> Forma parte de ObservableObject y sirve para que SwiftUI observe los cambios y renderice
    //state -> Forma base de SwiftUI para observar cambios en atributos y renderizar automaticamente
    //stateObject -> Objeto que solo se inicializa una sola vez durante el ciclo de vida de la vista
    //ObservableObject -> Protocolo de la cual se puede heredar en clases para que swiftUI la observer, y nos permite usar published

    
    func playerWon() {
        guard state == .playing else {return}
        for player in players {
            if player.score == winningPoints && winningPoints != 0 {
                DispatchQueue.main.async { //Hace que se ejecute cuando el calculo de la vista (renderizado) termina
                    self.state = .gameOver
                }
                player.changeWinner()
                player.addWin()
            }
        }
    }
    
    func winners() {
        guard state == .gameOver else {return}
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
        for player in players {
            if player.score == winningScore {
                player.changeWinner()
                player.addWin()
            }
        }
    }
    
    func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
            players[index].winner = false
        }
    }
}
