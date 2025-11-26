import Foundation
import SwiftData

@Model
class Grocery {
    var name: String
    var isBought: Bool

    init(name: String) {
        self.name = name
        self.isBought = false
    }
}

