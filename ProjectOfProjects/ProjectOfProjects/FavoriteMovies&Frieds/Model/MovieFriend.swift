import Foundation
import SwiftData

@Model
class MovieFriend {
    var name: String
    var favoriteMovie: Movie?
    private var newFriend: MovieFriend?

    init(name: String) {
        self.name = name
    }

    public static func addFriend(newFriend: MovieFriend?, context:ModelContext) {
        if let friend = newFriend {
            context.insert(friend)
        }
    }

    static let sampleData = [
           MovieFriend(name: "Elena"),
           MovieFriend(name: "Graham"),
           MovieFriend(name: "Mayuri"),
           MovieFriend(name: "Rich"),
           MovieFriend(name: "Rody"),
       ]
}

