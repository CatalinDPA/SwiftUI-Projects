//
//  Player.swift
//  ScoreKeeper
//
//  Created by Catalin Posedaru on 10/11/25.
//

import Foundation
import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    let color: Color = [
        .red,
        .blue,
        .cyan,
        .mint,
        .green
    ].randomElement() ?? .gray
    var name: String
    var score: Int
    var wins: Int
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name && lhs.score == rhs.score
    }
}
