//
//  ContentView.swift
//  Shared
//
//  Created by Zilin Zhu on 2021/1/6.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                Text("2048")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(textColor)
                GameBoard(model: model)
                    .padding()
            }
            Spacer()
        }
        .gesture(DragGesture()
                    .onEnded(dragGesture))
    }
    
    func dragGesture(value: DragGesture.Value) {

        let x = value.translation.width
        let y = value.translation.height
        let threshold: CGFloat = 20
        guard abs(x) > threshold || abs(y) > threshold else {
            return
        }
        
        var direction: Direction
        if abs(x) / abs(y) >= 1 {
            if x > 0 {
                direction = Direction.right
            } else {
                direction = Direction.left
            }
        } else {
            if y > 0 {
                direction = Direction.up
            } else {
                direction = Direction.down
            }
        }
        withAnimation {
            model.slide(to: direction)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
