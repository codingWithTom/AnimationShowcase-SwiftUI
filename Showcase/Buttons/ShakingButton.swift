//
//  ShakingButton.swift
//  Showcase
//
//  Created by Tomas Trujillo on 2021-04-11.
//  Copyright © 2021 CodingWithTom. All rights reserved.
//

import SwiftUI

struct ShakingButton: View {
  let action: () -> ()
  let isEnabled: Bool
  @State private var toggled: Bool = false {
    didSet {
      guard toggled else { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        toggled = false
      }
    }
  }
  
  var body: some View {
    CapsuleButton(action: {
      if isEnabled {
        action()
      } else {
        withAnimation {
          toggled.toggle()
        }
      }
    })
    .offset(x: toggled ? -5 : 0.0, y: 0)
    .animation(toggled ? .spring(response: 0.1, dampingFraction: 0.0, blendDuration: 0)
                : .linear(duration: 0.0), value: toggled)
  }
}

struct ShakingButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ShakingButton(action: {}, isEnabled: true)
      ShakingButton(action: {}, isEnabled: false)
    }
  }
}
