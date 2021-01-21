//
//  ContentView.swift
//  Shared
//
//  Created by Zilin Zhu on 2021/1/6.
//

import SwiftUI

struct ContentView: View {
    var model = Model()
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                Text("2048")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(textColor)
                    .padding(.top)
                GameBoard(model: model)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
