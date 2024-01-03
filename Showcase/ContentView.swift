//
//  ContentView.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-08-04.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var isShowingMessage: Bool = false
  
  var body: some View {
    TabView {
      customInputs
        .tabItem { Label("Inputs", systemImage: "button.horizontal.top.press.fill") }
      
      customAlerts
        .tabItem { Label("Alerts", systemImage: "alarm.waves.left.and.right.fill") }
      
      animateableInputs
        .tabItem { Label("Animateable", systemImage: "figure.run.square.stack.fill") }
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
    VStack {
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
      
      if !isShowingMessage {
        TimeButton(title: "Submit Order",
                   action: { isShowingMessage.toggle() })
      }
      
      if isShowingMessage {
        Text("Order Submitted!")
          .foregroundStyle(Color.red)
          .padding(.top)
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
