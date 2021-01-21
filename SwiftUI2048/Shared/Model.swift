//
//  Model.swift
//  SwiftUI2048
//
//  Created by Zilin Zhu on 2021/1/6.
//

import Foundation

enum Direction {
    case left
    case right
    case up
    case down

    var dx: Int {
        switch self {
            case .left: return -1
            case .right: return 1
            case .up: return 0
            case .down: return 0
        }
    }
    
    var dy: Int {
        switch self {
            case .left: return 0
            case .right: return 0
            case .up: return -1
            case .down: return 1
        }
    }
}

struct Block: Identifiable {
    var id: UUID = UUID()
    var pos: Int
    var val: Int

    // A block will disable only if it is covered
    var covered: Bool = false
    var merged: Bool = false
    
    var x: Int {
        pos / 4
    }
    
    var y: Int {
        pos % 4
    }
}

class Model: ObservableObject {
    @Published var blocks: [Block]
    // game over when there is no empty block
    @Published var end: Bool = false
    @Published var score: Int = 0
    // whether the model is in the middle of sliding
    @Published var sliding: Bool = false
    
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
        guard !end else {
            return
        }

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
            end = true
            return
        }

        let randPos: Int = emptyPos[Int.random(in: 0..<emptyPos.count)]
        blocks.append(Block(pos: randPos, val: Bool.random() ? 2 : 4))
    }

    func slide(to direction: Direction) {
        guard !sliding else {
            return
        }
        // sort blocks to make sure
        //      | |2|2|2| --right--> | | |2|4| not | | |4|2|
        blocks.sort {
            ($0.x - $1.x) * direction.dx > 0 || ($0.y - $1.y) * direction.dy < 0
        }
        
        var everMoved: Bool = false
        var moved: Bool = true
        while moved {
            moved = false
            for i in 0..<blocks.count {
                if blocks[i].covered { continue }
                moved = moveBlock(i: i, to: direction) || moved
            }
            if moved {
                everMoved = true
            }
        }
        
        if everMoved {
            sliding = true
        }
    }
    
    func moveBlock(i: Int, to direction: Direction) -> Bool {
        let new_x = blocks[i].x + direction.dx
        let new_y = blocks[i].y + direction.dy
        guard 0 <= new_x && new_x < 4 && 0 <= new_y && new_y < 4 else {
            return false
        }
        
        let new_pos = new_x * 4 + new_y
        
        for j in 0..<blocks.count {
            if i == j {
                continue
            }
            if new_pos == blocks[j].pos {
                if !blocks[i].merged && !blocks[j].merged && blocks[i].val == blocks[j].val {
                    blocks[i].covered = true
                    blocks[i].pos = new_pos
                    blocks[i].merged = true
                    blocks[j].merged = true
                    return true
                } else {
                    return false
                }
            }
        }
        for j in 0..<blocks.count {
            if blocks[j].pos == blocks[i].pos {
                blocks[j].pos = new_pos
            }
        }
        
        return true
    }
    
    func slideEnd() {
        guard sliding else {
            return
        }
        sliding = false
        // remove the covered blocks
        blocks = blocks.filter { !$0.covered }
        for i in 0..<blocks.count {
            if blocks[i].merged {
                blocks[i].val = 2 * blocks[i].val
                blocks[i].merged = false
            }
        }
        rand()
    }
}
