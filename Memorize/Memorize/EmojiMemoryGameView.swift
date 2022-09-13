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
        VStack {
            card
            shuffleButton
        }
    }
    
    var card: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture { game.choose(card) }
            }
        }
    }
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                        .padding(5)
                        .foregroundColor(.red)
                        .opacity(0.5)

                    Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / DrawingConstants.fontSize / DrawingConstants.fontScale
    }
}

// Magic Number
private struct DrawingConstants {
    static let fontScale: CGFloat = 1.5
    static let fontSize: CGFloat = 32
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
