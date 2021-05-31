//
//  RaffleView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/29/21.
//

import SwiftUI

struct RaffleView: View {
  @StateObject var raffle: Raffle
  
  var body: some View {
    VStack {
      HStack {
        if raffle.winnerId != nil {
          Image(systemName: "checkmark.circle")
            .padding()
            .foregroundColor(.green)
        }
        Spacer()
        Text("Raffle #: \(raffle.id)")
          .padding(.trailing)
      }
      Spacer()
        .frame(height: 30)
      Text("\(raffle.name)")
      Text("\(raffle.createdAt)")
      ZStack {
        Image("trophy2")
          .frame(width: 60, height: 60, alignment: Alignment.center)
          .scaledToFit()
          .clipped()
        if let winnerId = raffle.winnerId {
          Text("\(winnerId)")
            .bold()
        }
      }
      if raffle.winnerId != nil {
        Text("Winner ID")
      } else {
        Text("Draw a winner!")
          .foregroundColor(.blue)
      }
      
    }
  }
}

struct RaffleView_Previews: PreviewProvider {
  static var previews: some View {
    RaffleView(raffle:Raffle(id: 47, name: "Did you figure it out", createdAt: "2021-05-29T00:25:40.274Z", raffledAt: nil, winnerId: nil))
      .previewLayout(.sizeThatFits)
  }
}

