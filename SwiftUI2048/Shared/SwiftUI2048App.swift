//
//  SwiftUI2048App.swift
//  Shared
//
//  Created by Zilin Zhu on 2021/1/6.
//

import SwiftUI

@main
struct SwiftUI2048App: App {
    var body: some Scene {
        let model: Model = Model()
        WindowGroup {
            ContentView(model: model)
        }
        .commands {
            CommandMenu("Move") {
                Section {
                    Button("Up") {
                        withAnimation {
                            model.slide(to: .up)
                        }
                    }
                    .keyboardShortcut(.upArrow)
                    Button("Down") {
                        withAnimation {
                            model.slide(to: .down)
                        }
                    }
                    .keyboardShortcut(.downArrow)
                    Button("Left") {
                        withAnimation {
                            model.slide(to: .left)
                        }
                    }
                    .keyboardShortcut(.leftArrow)
                    Button("Right") {
                        withAnimation {
                            model.slide(to: .right)
                        }
                    }
                    .keyboardShortcut(.rightArrow)
                }
            }
        }
    }
}
