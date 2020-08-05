//
//  ContentView.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-08-04.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      RefreshButton()
      FlipToggleButton()
      SkewableTextfield()
    }
  .frame(width: 200)
  .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
