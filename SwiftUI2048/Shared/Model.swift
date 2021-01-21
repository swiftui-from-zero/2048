//
//  Model.swift
//  SwiftUI2048
//
//  Created by Zilin Zhu on 2021/1/21.
//

import Foundation

struct Block: Identifiable {
    var id: UUID = UUID()
    var pos: Int
    var val: Int
    
    var x: Int {
        pos / 4
    }
    
    var y: Int {
        pos % 4
    }
}

class Model {
    var blocks: [Block]
    
    init(numBlocks: [[Int]] = []) {
        blocks = []
        if numBlocks != [] {
            for y in 0..<4 {
                for x in 0..<4 {
                    if numBlocks[y][x] > 0 {
                        blocks.append(Block(pos: x * 4 + y, val: numBlocks[y][x]))
                    }
                }
            }
        } else {
            for _ in 0..<3 {
                rand()
            }
        }
    }
    
    func rand() {
        var emptyPos: [Int] = []
        for pos in 0..<16 {
            var empty = true
            for block in blocks {
                if block.pos == pos {
                    empty = false
                    break
                }
            }
            if empty {
                emptyPos.append(pos)
            }
        }

        guard emptyPos.count != 0 else {
            return
        }

        let randPos: Int = emptyPos[Int.random(in: 0..<emptyPos.count)]
        blocks.append(Block(pos: randPos, val: Bool.random() ? 2 : 4))
    }
}
