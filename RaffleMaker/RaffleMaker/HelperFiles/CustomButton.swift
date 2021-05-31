//
//  CustomButton.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/31/21.
//

import SwiftUI

struct MainButton: ButtonStyle {
  var color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: 150)
      .background(Color.white)
      .padding(5)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(color, lineWidth: 1))
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
  }
}
