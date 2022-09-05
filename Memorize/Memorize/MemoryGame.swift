//
//  MemoryGame.swift
//  Memorize
//
//  Created by 김동욱 on 2022/09/04.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            cards.append(Card(content: creatCardContent(pairIndex)))
            cards.append(Card(content: creatCardContent(pairIndex)))
        }
    }
}
