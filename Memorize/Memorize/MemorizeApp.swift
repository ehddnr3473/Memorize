//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 김동욱 on 2022/08/31.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
