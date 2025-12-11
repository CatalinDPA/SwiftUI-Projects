import Foundation

@Observable
class Alphabetizer {
    private let tileCount = 3
    private var vocab: Vocabulary

    var tiles = [Tile]()
    var score = 0
    var message: Message = .instructions
    var attempts = 0
    var difficulty = false

    init(vocab: Vocabulary = .oceanAnimals) {
        self.vocab = vocab
        startNewGame()
    }

    var getWinPercentage: Int {
        return attempts == 0 ? 0 : Int((Double(score) / Double(attempts)) * 100)
    }

    var consecutiveWins = 0
    func submit() {
        // Check if the tiles are alphabetized
        let userSortedTiles = tiles.sorted {
            $0.position.x < $1.position.x
        }

        let alphabeticallySortedTiles = tiles.sorted {
            $0.word.lexicographicallyPrecedes($1.word)
        }
        let isAlphabetized = userSortedTiles == alphabeticallySortedTiles
        // If alphabetized, increment the score
        if isAlphabetized {
            score += 1
            consecutiveWins += 1
        } else {
            consecutiveWins = 0
        }
        attempts += 1
        // Update the message to win or lose
        message = isAlphabetized ? .youWin : .tryAgain

        // Flip over correct tiles
        for (tile, correctTile) in zip(
            userSortedTiles,
            alphabeticallySortedTiles
        ) {
            let tileIsAlphabetized = tile == correctTile
            tile.flipped = tileIsAlphabetized
        }

        // Delay 2 seconds
        Task { @MainActor in
            try await Task.sleep(for: .seconds(2))
            // If alphabetized, generate new tiles
            if isAlphabetized {
                if consecutiveWins == 2 {
                    self.vocab = Vocabulary
                        .selectRandomCategory(actualVocab: vocab)
                    consecutiveWins = 0
                    //try await Task.sleep(for: .seconds(0.5))
                    await Task.yield()
                }
                startNewGame()
            }

            // Display instructions
            message = .instructions
        }
    }

    //MARK: private implementation

    private func startNewGame() {
        let newWords = vocab.selectRandomWords(count: tileCount)
        if tiles.isEmpty {
            for word in newWords {
                tiles.append(Tile(word: word))
            }
        } else {
            //asign new words to existing tiles
            for (tile, word) in zip(tiles, newWords) {
                tile.word = word
            }
        }
        for tile in tiles {
            tile.flipped = false
        }
    }
}
