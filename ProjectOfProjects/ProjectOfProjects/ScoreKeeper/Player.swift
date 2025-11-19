//
//  Player.swift
//  ScoreKeeper
//
//  Created by Catalin Posedaru on 10/11/25.
//

import Foundation
import SwiftUI

class Player: Identifiable {
    let id = UUID()
    let color: Color = [
        .red,
        .blue,
        .cyan,
        .mint,
        .green,
        .orange,
        .purple,
        .pink,
        .lightCyan,
        .teal
    ].randomElement() ?? .gray
    var name: String
    var score: Int
    var winner: Bool
    var wins: Int
    
    init(name: String, score: Int, winner: Bool, wins: Int) {
        self.name = name
        self.score = score
        self.winner = winner
        self.wins = wins
    }
    
    func changeWinner() {
        self.winner = !self.winner
    }
    
    func addWin() {
        self.wins += 1
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name && lhs.score == rhs.score
    }
}
