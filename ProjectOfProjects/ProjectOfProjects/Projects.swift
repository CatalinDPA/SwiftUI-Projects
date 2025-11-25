import SwiftUI
import SwiftData

enum Projects: CaseIterable {
    case diceRoller
    case addressLabel
    case chatPrototype
    case pickAPal
    case scoreKeeper
    case birthdays

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
        }
    }
    
    var navigationView: some View {
        switch self {
        case .diceRoller:
            return AnyView(ContentViewPickAPal())
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
        }
    }
}
