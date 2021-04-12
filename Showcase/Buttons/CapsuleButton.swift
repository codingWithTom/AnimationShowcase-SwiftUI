//
//  CapsuleButton.swift
//  Showcase
//
//  Created by Tomas Trujillo on 2021-04-11.
//  Copyright © 2021 CodingWithTom. All rights reserved.
//

import SwiftUI

struct CapsuleButton: View {
  var title: String = "Large Button"
  let action: () -> Void
  
  var body: some View {
    Button(action: action, label: {
      Text(title)
        .font(.title)
        .bold()
        .padding()
    })
    .buttonStyle(ShowcaseCapsuleButtonStyle())
  }
}

struct ShowcaseCapsuleButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(configuration.isPressed ? Color.white : Color.yellow)
      .foregroundColor(configuration.isPressed ? Color.yellow : Color.white)
      .clipShape(Capsule())
  }
}

struct CapsuleButton_Previews: PreviewProvider {
  static var previews: some View {
    CapsuleButton(action: {})
  }
}
