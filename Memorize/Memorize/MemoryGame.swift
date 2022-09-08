//
//  MemoryGame.swift
//  Memorize
//
//  Created by 김동욱 on 2022/09/04.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set): 외부에서 볼 수 있지만 설정할 수는 없음.
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly } // (return)
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    // Logic of MemoryGame
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {  $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchedIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchedIndex].content == cards[chosenIndex].content { // content: CardContent -> + where CardContent: Equatable
                    cards[potentialMatchedIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            cards.append(Card(content: creatCardContent(pairIndex), id: pairIndex*2))
            cards.append(Card(content: creatCardContent(pairIndex), id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int // For identifiable
    }
}

// extension of struct
// self.count, self.first
extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
