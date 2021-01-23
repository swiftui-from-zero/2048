//
//  Model.swift
//  SwiftUI2048
//
//  Created by Zilin Zhu on 2021/1/21.
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

    func slide(to direction: Direction) {
        for i in 0..<blocks.count {
            blocks[i].merged = false
        }
        // sort blocks to make sure
        //      | |2|2|2| --right--> | | |2|4| not | | |4|2|
        blocks.sort {
            ($0.x - $1.x) * direction.dx > 0 || ($0.y - $1.y) * direction.dy > 0
        }

        var everMoved: Bool = false
        var moved: Bool = true
        while moved {
            moved = false
            for i in 0..<blocks.count {
                if moveBlock(i: i, to: direction) {
                    moved = true
                    everMoved = true
                    break
                }
            }
        }
        if everMoved {
            rand()
        }
    }

    func moveBlock(i: Int, to direction: Direction) -> Bool {
        guard !blocks[i].merged else {
            return false
        }
        
        let new_x = blocks[i].x + direction.dx
        let new_y = blocks[i].y + direction.dy

        guard 0 <= new_x && new_x < 4 && 0 <= new_y && new_y < 4 else {
            return false
        }

        let new_pos = new_x * 4 + new_y

        for j in 0..<blocks.count {
            if new_pos == blocks[j].pos {
                if blocks[i].val == blocks[j].val {
                    blocks[j].val *= 2
                    blocks[j].merged = true
                    blocks.remove(at: i)
                    return true
                } else {
                    return false
                }
            }
        }
        blocks[i].pos = new_pos
        return true
    }
}
