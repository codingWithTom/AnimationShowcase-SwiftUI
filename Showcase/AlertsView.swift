//
//  AlertsView.swift
//  Showcase
//
//  Created by Tomas Trujillo on 2021-04-11.
//  Copyright © 2021 CodingWithTom. All rights reserved.
//

import SwiftUI

struct AlertsView: View {
  @State private var isShowingBanner: Bool = false
  @State private var isShowingToast: Bool = false
  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      CapsuleButton(title: "Show Banner", action: { withAnimation { isShowingBanner.toggle() } })
      CapsuleButton(title: "Show Toast", action: { withAnimation { isShowingToast.toggle() } })
      Spacer()
    }
    .modifier(Banner(isShowing: $isShowingBanner, message: "This is an error message"))
    .modifier(Toast(isShowing: $isShowingToast, message: "Something went wrong"))
  }
}

struct AlertsView_Previews: PreviewProvider {
  static var previews: some View {
    AlertsView()
  }
}
