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
    TabView {
      customInputs
        .tabItem { Text("Inputs") }
      
      customAlerts
        .tabItem { Text("Alerts") }
      
      animateableInputs
        .tabItem { Text("Animateable") }
    }
  }
  
  private var animateableInputs: some View {
    VStack {
      RefreshButton()
      FlipToggleButton()
      SkewableTextfield()
    }
  .frame(width: 200)
  .padding()
  }
  
  private var customInputs: some View {
    HStack {
      VStack {
        CapsuleButton(action: {})
        ShakingButton(action: {}, isEnabled: false)
      }
      VStack {
        ImageButton(imageName: "suit.heart.fill", isTemplate: true, action: {})
          .foregroundColor(.red)
        ImageButton(imageName: "anvil", isTemplate: false, action: {})
      }
    }
  }
  
  private var customAlerts: some View {
    AlertsView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
