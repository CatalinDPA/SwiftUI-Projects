import Foundation

struct Vocabulary {
    let words: [String]
    let id = UUID()

    /// - returns: `count` unique, random words from `words`, guaranteed unsorted
    func selectRandomWords(count: Int) -> [String] {
        var newWords = Array(words.shuffled().prefix(count))
        while newWords.sorted() == newWords {
            newWords.shuffle()
        }
        return newWords
    }

    static func selectRandomCategory(actualVocab: Vocabulary) -> Vocabulary {
        var categories = [Vocabulary.insects, Vocabulary.landAnimals, Vocabulary.oceanAnimals].randomElement()
        if let vocab = categories {
            while categories != actualVocab {
                categories = [Vocabulary.insects, Vocabulary.landAnimals, Vocabulary.oceanAnimals].randomElement()
            }
            return vocab
        }
        return Vocabulary(words: ["Internal error"])
    }

    static let icons: [String: String] = [
        "Bear": "🐻",
        "Duck": "🦆",
        "Frog": "🐸",
        "Fox": "🦊",
        "Goose": "🪿",
        "Lizard": "🦎",
        "Panda": "🐼",
        "Rabbit": "🐇",
        "Sheep": "🐑",
        "Crab": "🦀",
        "Jellyfish": "🪼",
        "Octopus": "🦑",
        "Whale": "🐳",
        "Ant": "🐜",
        "Bee": "🐝",
        "Ladybug": "🐞",
        "Spider": "🕷️",
        "Butterfly": "🦋",
        "Scorpion": "🦂"
    ]
}



extension Vocabulary {
    static let insects = Vocabulary(words: [
        "Ant",
        "Bee",
        "Ladybug",
        "Spider",
        "Butterfly",
        "Scorpion"
    ])
    static let landAnimals = Vocabulary(words: [
        "Bear",
        "Duck",
        "Frog",
        "Fox",
        "Goose",
        "Lizard",
        "Panda",
        "Rabbit",
        "Sheep",
    ])

    static let oceanAnimals = Vocabulary(words: [
        "Crab",
        "Jellyfish",
        "Octopus",
        "Whale",
    ])
}

extension Vocabulary: Equatable {
    static func == (lhs: Vocabulary, rhs: Vocabulary) -> Bool {
        lhs.id == rhs.id
    }
}
