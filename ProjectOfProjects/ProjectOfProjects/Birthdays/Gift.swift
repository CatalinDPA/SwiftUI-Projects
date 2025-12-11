import Foundation
import SwiftData

@Model
class Gift {
    var name: String
    var friends = [Friend]()

    init(name: String) {
        self.name = name
    }
}
