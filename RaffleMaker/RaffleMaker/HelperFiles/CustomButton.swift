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
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(color, lineWidth: 1))
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
  }
}

/*
 configuration.label
             .padding(.horizontal,20)
             .padding(10)
             .background(Color.background)
             .cornerRadius(5)
             .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
             .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
             .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
 */
