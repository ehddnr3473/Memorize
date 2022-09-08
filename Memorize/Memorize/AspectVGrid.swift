//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 김동욱 on 2022/09/08.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    let items: [Item]
    let aspectRatio: CGFloat
    let content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat,  @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width = widthThatFits(itemCount: items.count, in: geometry.size, itemAsepctRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: .zero) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
            
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = .zero
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAsepctRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAsepctRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}
