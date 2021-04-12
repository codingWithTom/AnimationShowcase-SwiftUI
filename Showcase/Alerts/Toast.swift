//
//  Toast.swift
//  Showcase
//
//  Created by Tomas Trujillo on 2021-04-11.
//  Copyright © 2021 CodingWithTom. All rights reserved.
//

import SwiftUI

struct ToastView: View {
  let message: String
  let onDismissAction: () -> Void
  
  var body: some View {
    HStack {
      Text(message)
        .multilineTextAlignment(.center)
        .padding()
        .background(
          Rectangle()
            .fill(Color.white)
            .clipShape(Capsule())
            .shadow(color: .black, radius: 2, x: 0.0, y: 1.0)
        )
      ImageButton(imageName: "arrow.down", isTemplate: true, action: onDismissAction)
    }
  }
}

struct Toast: ViewModifier {
  let message: String
  @Binding private var isShowing: Bool
  @ObservedObject private var dismissable: DismissableViewModel
  
  init(isShowing: Binding<Bool>, message: String) {
    self.message = message
    self._isShowing = isShowing
    self.dismissable = DismissableViewModel(isShowing: isShowing.wrappedValue)
  }
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottom) {
      content
        .zIndex(1.0)
      if dismissable.isShowing {
        ToastView(message: message) {
          withAnimation {
            dismissable.isShowing = false
          }
        }
        .transition(.move(edge: .bottom))
        .zIndex(2.0)
        .padding(.bottom, 20)
      }
    }
    .onReceive(dismissable.$isShowing, perform: { showing in
      self.isShowing = showing
    })
  }
}

struct Toast_Previews: PreviewProvider {
  static var previews: some View {
    ToastView(message: "There was an error", onDismissAction: {})
  }
}
