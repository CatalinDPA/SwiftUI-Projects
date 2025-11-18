import SwiftUI

enum Projects: CaseIterable {
    case diceRoller
    case addressLabel
    case chatPrototype
    case pickAPal
    case scoreKeeper
    
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
        }
    }
}
