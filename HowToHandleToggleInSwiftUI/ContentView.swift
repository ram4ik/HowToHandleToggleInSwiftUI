//
//  ContentView.swift
//  HowToHandleToggleInSwiftUI
//
//  Created by ramil on 05/10/2019.
//  Copyright © 2019 com.ri. All rights reserved.
//

import SwiftUI

class TestStore: ObservableObject {
    var text = ""
    @Published var isOn = true {
        willSet {
            self.text = newValue ? "Turn on" : "Turn off"
        }
    }
}

struct ContentView: View {
    @ObservedObject var store = TestStore()
    @State private var rotateA = false
    @State private var rotateB = false
    
    let fromLeftToRight = LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .leading, endPoint: .trailing)
    let fromTopToBottom = LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .top, endPoint: .bottom)
    let fromLeftToTopRight = LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .leading, endPoint: .topTrailing)
    let fromRightToTopLeft = LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: UnitPoint(x: 0.9, y: 0.9), endPoint: UnitPoint(x: 0.25, y: 0.25))
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(self.store.isOn ?
                    (self.rotateA && self.rotateB ? fromLeftToRight : fromRightToTopLeft) :
                    (self.rotateA && self.rotateB ? fromTopToBottom : fromLeftToTopRight))
                .edgesIgnoringSafeArea(.all)
                .animation(.default)
            
            VStack {
                Text(store.text)
                Toggle(isOn: $store.isOn) {
                    Text("On:")
                }.fixedSize()
                Button(action: {
                    self.rotateA.toggle()
                    self.rotateB.toggle()
                }) {
                    Text("Rotate")
                        .bold()
                }
            }
        }.onTapGesture {
            self.rotateA.toggle()
            self.store.isOn.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
