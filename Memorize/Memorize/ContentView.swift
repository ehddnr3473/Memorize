//
//  ContentView.swift
//  Memorize
//
//  Created by 김동욱 on 2022/08/31.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚"]
    @State var emojisCount: Int = 6
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis[0..<emojisCount], id: \.self) { emoji in
                        CardView(emoji: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                addButton
                Spacer()
                removeButton
            }
            .padding()
        }
    }
    
    var addButton: some View {
        Button(action: {
            if emojisCount < emojis.count {
                emojisCount += 1
            }
        }) {
            Image(systemName: "plus.circle")
                .font(.largeTitle)
        }
    }
    
    var removeButton: some View {
        Button(action: {
            if emojisCount > 0 {
                emojisCount -= 1
            }
        }) {
            Image(systemName: "minus.circle")
                .font(.largeTitle)}
    }
}




struct CardView: View {
    @State var isFaceUp: Bool = false
    var emoji: String
    var shape = RoundedRectangle(cornerRadius: 25)
    
    var body: some View {
        ZStack {
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                
                shape
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.red)
                
                Text(emoji)
                    .font(.largeTitle)
            } else {
                shape
                    .fill()
                    .foregroundColor(.red)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
