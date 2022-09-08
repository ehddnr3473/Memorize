//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 김동욱 on 2022/08/31.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // viewModel의 변화 감지
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(.zero)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture { game.choose(card) }
            }
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        // GeometryReader로 CardView의 크기를 계산
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
                    
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                        .padding(5)
                        .foregroundColor(.red)
                        .opacity(0.5)
                    
                    Text(card.content)
                        .font(font(in: geometry.size))
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

// Magic Number
private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.70
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
