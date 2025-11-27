import Foundation
import SwiftData

@Model
class MovieFriend {
    var name: String
    var favoriteMovie: Movie?

    init(name: String) {
        self.name = name
    }

    static let sampleData = [
           MovieFriend(name: "Elena"),
           MovieFriend(name: "Graham"),
           MovieFriend(name: "Mayuri"),
           MovieFriend(name: "Rich"),
           MovieFriend(name: "Rody"),
       ]
}

