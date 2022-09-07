//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 김동욱 on 2022/09/04.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚"]
    
    private static func creatMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    @Published private var model = creatMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - User Intents
    func choose(_ card: Card) {
        model.choose(card)
    }
}
