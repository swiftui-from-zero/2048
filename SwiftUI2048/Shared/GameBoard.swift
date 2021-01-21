//
//  GameBoard.swift
//  SwiftUI2048
//
//  Created by Zilin Zhu on 2021/1/21.
//

import SwiftUI

struct BlankBlock: View {
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(blankColor)
            .padding(5)
            .frame(width: width, height: height)
    }
}

struct NumberBlock: View {
    var width: CGFloat
    var height: CGFloat
    var val: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(colorPalette[val]!)
            .padding(5)
            .frame(width: width, height: height)
            .overlay(Text("\(String(val))")
                        .font(val < 1024 ?
                                .system(size: width / 3) :
                                .system(size: width / 4))
                        .fontWeight(.bold)
                        .foregroundColor(val >= 8 ?
                                        Color.white :
                                        secondBackgroundColor))
    }
}

struct GameBoard: View {
    var model: Model

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(secondBackgroundColor)
            .aspectRatio(1.0, contentMode: .fit)
            .overlay(content)
    }
    
    var content: some View {
        GeometryReader { geometry in
            blankBoard(for: geometry.size)
            numberBoard(for: geometry.size)
        }
        .padding(5)
    }

    func blankBoard(for size: CGSize) -> some View {
        ForEach(0..<4) { x in
            ForEach(0..<4) { y in
                BlankBlock(width: size.width / 4,
                          height: size.height / 4)
                    .offset(x: CGFloat(x) * size.width / 4,
                           y: CGFloat(y) * size.height / 4)
            }
        }
    }

    func numberBoard(for size: CGSize) -> some View {
        ForEach(model.blocks) { block in
            NumberBlock(width: size.width / 4,
                       height: size.height / 4,
                       val: block.val)
                .offset(x: CGFloat(block.x) * size.width / 4,
                       y: CGFloat(block.y) * size.height / 4)
        }
    }
}

struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard(model: Model(numBlocks:
                                [[0, 2, 4, 8],
                                 [16, 32, 64, 128],
                                 [256, 512, 1024, 2048],
                                 [4096, 8192, 16384, 32768]]))
    }
}
