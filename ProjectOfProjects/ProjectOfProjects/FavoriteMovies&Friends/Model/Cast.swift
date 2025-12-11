//
//  Cast.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 4/12/25.
//

import Foundation
import SwiftData

@Model
class Cast {
    var name: String
    var movies = [Movie]()

    init(name: String) {
        self.name = name
    }

    static let sampleData = [
           Cast(name: "Elena"),
           Cast(name: "Graham"),
           Cast(name: "Mayuri"),
           Cast(name: "Rich"),
           Cast(name: "Rody"),
       ]
}

