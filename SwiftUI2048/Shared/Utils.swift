//
//  Utils.swift
//  SwiftUI2048
//
//  Created by Zilin Zhu on 2021/1/6.
//

import SwiftUI

extension Color {
    init(hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

let colorPalette: [Int: Color] = [
    0: Color(hex: 0xFFFFFF),
    2: Color(hex: 0xEEE4DA),
    4: Color(hex: 0xEDE0C8),
    8: Color(hex: 0xF2B179),
    16: Color(hex: 0xF59563),
    32: Color(hex: 0xFF7355),
    64: Color(hex: 0xF65E3B),
    128: Color(hex: 0xEDCF72),
    256: Color(hex: 0xF3CD5F),
    512: Color(hex: 0xF3CB49),
    1024: Color(hex: 0xF5C62D),
    2048: Color(hex: 0xF6C100),
    4096: Color(hex: 0x3E3A32),
    8192: Color(hex: 0x3E3A32),
    16384: Color(hex: 0x3E3A32),
    32768: Color(hex: 0x3E3A32),
    65536: Color(hex: 0x3E3A32)
]

let blankColor = Color(hex: 0xCFC1B1)

let backgroundColor: Color = Color(hex: 0xFAF8EF)
let secondBackgroundColor = Color(hex: 0xBEAC9E)

let textColor: Color = Color(hex: 0x776E65)
