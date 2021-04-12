//
//  ImageButton.swift
//  Showcase
//
//  Created by Tomas Trujillo on 2021-04-11.
//  Copyright © 2021 CodingWithTom. All rights reserved.
//

import SwiftUI

struct ImageButton: View {
  let imageName: String
  let isTemplate: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action, label: {
      image
        .renderingMode(isTemplate ? .template : .original)
        .padding()
    })
    .background(
      Circle()
        .fill(Color.white)
        .shadow(color: .black, radius: 2, x: 0, y: 2)
    )
  }
  
  var image: Image {
    if isTemplate {
      return Image(systemName: imageName)
    } else {
      return Image(imageName)
    }
  }
}

struct ImageButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ImageButton(imageName: "suit.heart.fill", isTemplate: true, action: {})
        .foregroundColor(.red)
      ImageButton(imageName: "anvil", isTemplate: false, action: {})
        .foregroundColor(.red)
    }
  }
}
