//
//  SkewableTextfield.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-08-04.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import SwiftUI

struct SkewableTextfield: View {
  @State private var text: String = ""
  @State private var isTextDeleted: Bool = false
  
  var body: some View {
    ZStack {
      TextField("Write text here", text: $text)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      if text != "" {
        HStack {
          Spacer()
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.blue)
            .onTapGesture {
              withAnimation {
                self.text = ""
                self.isTextDeleted.toggle()
              }
          }
        }
        .padding(.trailing, 8.0)
        .transition(.opacity)
      }
    }
    .modifier(ShakeEffect(isAnimating: isTextDeleted))
    .animation(.spring(), value: isTextDeleted)
  }
}

struct ShakeEffect: GeometryEffect {
  private var percentage: CGFloat
  
  var animatableData: CGFloat {
    get { return percentage }
    set { percentage = newValue }
  }
  
  init(isAnimating: Bool) {
    self.percentage = isAnimating ? 0 : 1
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    let fullSkew: CGFloat = 0.25
    guard percentage != 0, percentage != 1 else {  return ProjectionTransform(.identity) }
    let skew: CGFloat
    if percentage < 0.25 {
      skew = fullSkew * percentage / 0.25
    } else if percentage < 0.5 {
      skew = -fullSkew * percentage / 0.5
    } else if percentage < 0.75 {
      skew = fullSkew / 2 * percentage / 0.75
    } else {
      skew = -fullSkew / 2 * percentage / 1.0
    }
    var transform = CGAffineTransform.identity
    transform.c = skew
    return ProjectionTransform(transform)
  }
}

struct SkewableTextfield_Previews: PreviewProvider {
  static var previews: some View {
    SkewableTextfield()
  }
}
