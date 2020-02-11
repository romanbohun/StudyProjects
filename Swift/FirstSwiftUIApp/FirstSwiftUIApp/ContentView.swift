//
//  ContentView.swift
//  FirstSwiftUIApp
//
//  Created by Roman Bogun on 6/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        Text("Hello World")
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
