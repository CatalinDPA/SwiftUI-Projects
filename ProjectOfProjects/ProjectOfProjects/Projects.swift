import SwiftUI
import SwiftData

enum Projects: CaseIterable {
    case diceRoller
    case addressLabel
    case chatPrototype
    case pickAPal
    case scoreKeeper
    case birthdays
    case groceryList
    case movieFriends
    case alphabetizer

    var title: String {
        switch self {
        case .diceRoller:
            return "Dice Roller"
        case .addressLabel:
            return "Address Label"
        case .chatPrototype:
            return "Chat Prototype"
        case .pickAPal:
            return "Pick-a-Pal"
        case .scoreKeeper: 
            return "Score Keeper"
        case .birthdays:
            return "Birthdays list"
        case .groceryList:
            return "Grocery list"
        case .movieFriends:
            return "Movies & Friends"
        case .alphabetizer:
            return "Alphabetizer"
        }
    }
    
    var navigationView: some View {
        switch self {
        case .diceRoller:
            return AnyView(ContentViewDice())
        case .addressLabel:
            return AnyView(ContentViewAddressLabel())
        case .chatPrototype:
            return AnyView(ContentViewChatPrototype())
        case .pickAPal:
            return AnyView(ContentViewPickAPal())
        case .scoreKeeper:
            return AnyView(ContentViewScoreKeeper())
        case .birthdays:
            return AnyView(ContentViewBirthdays())
        case .groceryList:
            return AnyView(ContentViewGrocery())
        case .movieFriends:
            return AnyView(ContentViewMovieFriends())
        case .alphabetizer:
            return AnyView(ContentViewAlphabetizer())
        }
    }
}
