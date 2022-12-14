//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by κΉλμ± on 2022/09/04.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["π", "π", "π", "π", "π", "π", "π", "π", "π", "π", "π»", "π"]
    
    private static func creatMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    // λ³κ²½λ  λλ§λ€ send()
    @Published private var model = creatMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - User Intents
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.creatMemoryGame()
    }
}
