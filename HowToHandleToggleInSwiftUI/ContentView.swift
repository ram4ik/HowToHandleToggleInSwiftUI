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
    var body: some View {
        VStack {
            Text(store.text)
            Toggle(isOn: $store.isOn) { Text("On:")}.fixedSize()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
