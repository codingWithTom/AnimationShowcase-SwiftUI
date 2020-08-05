//
//  FlipToggleButton.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-08-04.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import SwiftUI

struct FlipToggleButton: View {
  @State private var isOn: Bool = true
  var body: some View {
    Image(systemName: isOn ? "checkmark.seal.fill" : "xmark.seal.fill")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .foregroundColor(isOn ? .green : .red)
      .rotation3DEffect(Angle(degrees: isOn ? 360 : 0.0), axis: (x: 1.0, y: 0.0, z: 0.0))
      .animation(.easeOut(duration: 1.0))
      .modifier(TossingEffect(isAnimating: isOn))
      .animation(.easeOut(duration: 1.0))
      .onTapGesture {
        self.isOn.toggle()
    }
  }
}

struct TossingEffect: GeometryEffect {
  private var percentage: CGFloat
  
  var animatableData: CGFloat {
    get { return percentage }
    set { percentage = newValue }
  }
  
  init(isAnimating: Bool) {
    self.percentage = isAnimating ? 0 : 1
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    let translation: CGFloat = -size.height / 2
    let transform: CGAffineTransform
    if percentage <= 0.5 {
      transform = CGAffineTransform(translationX: 0.0, y: translation * (percentage / 0.5))
    } else {
      transform = CGAffineTransform(translationX: 0.0, y: (1 + translation) - translation * (percentage - 0.5) / 0.5)
    }
    return ProjectionTransform(transform)
  }
}

struct FlipToggleButton_Previews: PreviewProvider {
  static var previews: some View {
    FlipToggleButton()
  }
}
