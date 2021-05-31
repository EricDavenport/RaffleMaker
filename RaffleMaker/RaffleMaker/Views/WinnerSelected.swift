//
//  WinnerSelected.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/31/21.
//

import SwiftUI

struct WinnerSelected: View {
  @Binding var winnerId: Int
  @Binding var winnerSelected: Bool
  
  var body: some View {
    ZStack {
      Image(systemName: winnerSelected ? "star.fill" : "star")
        .resizable()
//        .rotationEffect(.degrees(winnerSelected ? 360 : -360))
//        .scaleEffect(winnerSelected ? 1 : 0.15, anchor: .center)
        .foregroundColor(.yellow)
        .frame(width: 100, height: 100)
      
      Text("\(winnerId)")
        .bold() 
    }
    .opacity(winnerSelected ? 1 : 0)
    .animation(.easeOut)
  }
}

struct WinnerSelected_Previews: PreviewProvider {
  static var previews: some View {
    WinnerSelected(winnerId: .constant(46), winnerSelected: .constant(false))
  }
}
