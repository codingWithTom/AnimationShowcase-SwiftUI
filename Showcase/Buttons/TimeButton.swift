//
//  TimeButton.swift
//  Showcase
//
//  Created by Tomas Trujillo on 2024-01-02.
//  Copyright © 2024 CodingWithTom. All rights reserved.
//

import SwiftUI

struct TimeButton: View {
  @State private var isAnimating: Bool = false
  let title: String
  var time: Double = 4
  let action: () -> Void
  
  var body: some View {
    CapsuleButton(title: title, action: action)
      .overlay(
        TimedCapsule(isActive: isAnimating) { action() }
          .stroke(Color.red, lineWidth: 5)
          .animation(.easeInOut(duration: time), value: isAnimating)
      )
      .onAppear { withAnimation { isAnimating = true } }
  }
}

struct TimedCapsule: Shape {
  var percent: CGFloat
  var animatableData: CGFloat {
    get { percent }
    set {
      percent = newValue
      if newValue == 1.0 {
        onFinished()
      }
    }
  }
  private let onFinished: @Sendable () -> Void
  
  init(isActive: Bool, onFinished: @Sendable @escaping () -> Void) {
    percent = isActive ? 1.0 : 0.0
    self.onFinished = onFinished
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: .init(x: rect.midX, y: rect.minY))
    addFirstLine(to: &path, in: rect)
    addTrailingArc(to: &path, in: rect)
    addSecondLine(to: &path, in: rect)
    addLeadingArc(to: &path, in: rect)
    addThirdLine(to: &path, in: rect)
    return path
  }
  
  private func addFirstLine(to path: inout Path, in rect: CGRect) {
    let maxPercent = 0.15
    let relativePercent = min(maxPercent, percent)
    let totalDistance = (rect.maxX - rect.midY) - rect.midX
    let distance = totalDistance * (relativePercent / maxPercent)
    let point = CGPoint(x: rect.midX + distance, y: rect.minY)
    path.addLine(to: point)
  }
  
  private func addTrailingArc(to path: inout Path, in rect: CGRect) {
    let maxPercent = 0.3
    let minPercent = 0.15
    guard percent > minPercent else { return }
    let relativePercent = min(maxPercent, percent)
    let angle = 180 * (relativePercent - minPercent) / (maxPercent - minPercent)
    path.addRelativeArc(center: .init(x: rect.maxX - rect.midY,
                                      y: rect.midY),
                        radius: rect.midY,
                        startAngle: .degrees(-90),
                        delta: .degrees(angle))
  }
  
  private func addSecondLine(to path: inout Path, in rect: CGRect) {
    let maxPercent = 0.70
    let minPercent = 0.30
    guard percent > minPercent else { return }
    let relativePercent = min(maxPercent, percent)
    let totalDistance = rect.maxX - rect.midY * 2
    let distance = totalDistance * (relativePercent - minPercent) / (maxPercent - minPercent)
    let point = CGPoint(x: rect.maxX - rect.midY - distance,
                        y: rect.maxY)
    path.addLine(to: point)
  }
  
  private func addLeadingArc(to path: inout Path, in rect: CGRect) {
    let maxPercent = 0.85
    let minPercent = 0.7
    guard percent > minPercent else { return }
    let relativePercent = min(maxPercent, percent)
    let angle = 180 * (relativePercent - minPercent) / (maxPercent - minPercent)
    path.addRelativeArc(center: .init(x: rect.midY,
                                      y: rect.midY),
                        radius: rect.midY,
                        startAngle: .degrees(90),
                        delta: .degrees(angle))
  }
  
  private func addThirdLine(to path: inout Path, in rect: CGRect) {
    let maxPercent = 1.0
    let minPercent = 0.85
    guard percent > minPercent else { return }
    let relativePercent = min(maxPercent, percent)
    let totalDistance = rect.midX - rect.midY
    let distance = totalDistance * (relativePercent - minPercent) / (maxPercent - minPercent)
    let point = CGPoint(x: rect.midY + distance,
                        y: rect.minY)
    path.addLine(to: point)
  }
}

#Preview {
  TimeButton(title: "      Press Me      ", action: { })
}
