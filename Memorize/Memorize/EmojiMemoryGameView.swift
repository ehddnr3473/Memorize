//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 김동욱 on 2022/08/31.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }.padding()
            }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape
                        .fill()
                        .foregroundColor(.white)
                    
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.red)
                    
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape
                        .opacity(.zero)
                } else {
                    shape
                        .fill()
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 25
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.8
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
