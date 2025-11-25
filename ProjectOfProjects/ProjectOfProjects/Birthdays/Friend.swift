import Foundation
import SwiftData

@Model
class Friend {
    var name: String
    var birthday: Date
    var notes: String
    
    init(name: String, birthday: Date, notes: String) {
        self.name = name
        self.birthday = birthday
        self.notes = notes
    }
    
    var isBirthdayToday: Bool {
        Calendar.current.isDateInToday(birthday)
    }
}

