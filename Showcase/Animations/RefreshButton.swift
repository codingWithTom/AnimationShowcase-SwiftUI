//
//  RefreshButton.swift
//  AnimationShowcase
//
//  Created by Tomas Trujillo on 2020-08-04.
//  Copyright © 2020 CodingWithTom. All rights reserved.
//

import SwiftUI

struct RefreshButton: View {
  @State private var isAnimating: Bool = false
  
  var body: some View {
    CycleArrows()
      .stroke(Color.blue, style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
      .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0.0))
      .animation(isAnimating ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) :
        Animation.linear(duration: 0.0))
      .modifier(ScaleEffect(isAnimating: isAnimating))
      .animation(isAnimating ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : .linear(duration: 0.0))
      .contentShape(Rectangle())
      .aspectRatio(contentMode: .fit)
      .onTapGesture {
        self.isAnimating.toggle()
    }
  }
}

struct CycleArrows: Shape {
  func path(in rect: CGRect) -> Path {
    let padding: CGFloat = 8.0
    let leftEdgePoint = CGPoint(x: 0.0 + padding, y: 0.0 + padding)
    let rightEdgePoint = CGPoint(x: rect.width - padding, y: rect.height - padding)
    let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
    let arrowLength = rect.width / 12
    let arrowPadding: Double = .pi / 12
    var path = Path()
    path.move(to: CGPoint(x: leftEdgePoint.x, y: centerPoint.y))
    path.addArc(center: centerPoint, radius: centerPoint.x - leftEdgePoint.x,
                startAngle: Angle(radians: .pi),
                endAngle: Angle(radians:0.0 - arrowPadding),
                clockwise: false)
    var arrowPoint = path.currentPoint ?? .zero
    path.move(to: CGPoint(x: arrowPoint.x - arrowLength, y: arrowPoint.y - arrowLength / 2))
    path.addLine(to: arrowPoint)
    path.move(to: CGPoint(x: arrowPoint.x + arrowLength / 3, y: arrowPoint.y - arrowLength))
    path.addLine(to: arrowPoint)
    
    path.move(to: CGPoint(x: rightEdgePoint.x, y: centerPoint.y))
    path.addArc(center: centerPoint, radius: centerPoint.x - leftEdgePoint.x,
                startAngle: Angle(radians: 0.0),
                endAngle: Angle(radians: .pi - arrowPadding),
                clockwise: false)
    arrowPoint = path.currentPoint ?? .zero
    path.move(to: CGPoint(x: arrowPoint.x - arrowLength / 2, y: arrowPoint.y + arrowLength))
    path.addLine(to: arrowPoint)
    path.move(to: CGPoint(x: arrowPoint.x + arrowLength, y: arrowPoint.y + arrowLength * 2 / 3))
    path.addLine(to: arrowPoint)
    
    return path
  }
}

struct ScaleEffect: GeometryEffect {
  private var percentage: CGFloat
  
  var animatableData: CGFloat {
    get { return percentage }
    set { percentage = newValue }
  }
  
  init(isAnimating: Bool) {
    self.percentage = isAnimating ? 0 : 1
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    let additionalScale: CGFloat = 0.25
    let scale: CGFloat
    if percentage <= 0.5 {
      scale = 1.0 + additionalScale * (percentage / 0.5)
    } else {
      scale = (1.0 + additionalScale) - additionalScale * ((percentage - 0.5) / 0.5)
    }
    var transform = CGAffineTransform(translationX: -size.width / 2.0, y: -size.height / 2.0)
    transform = transform.concatenating(CGAffineTransform(scaleX: scale, y: scale))
    let anchorPointTransform = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
    return ProjectionTransform(transform).concatenating(ProjectionTransform(anchorPointTransform))
  }
}

struct RefreshButton_Previews: PreviewProvider {
  static var previews: some View {
    RefreshButton()
  }
}
