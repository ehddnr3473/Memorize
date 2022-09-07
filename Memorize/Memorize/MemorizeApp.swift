//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 김동욱 on 2022/08/31.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
