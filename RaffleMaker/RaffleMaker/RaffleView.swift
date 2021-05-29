//
//  RaffleView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/29/21.
//

import SwiftUI

struct RaffleView: View {
  @EnvironmentObject var raffle: Raffle
  var body: some View {
    VStack {
      HStack() {
        Spacer()
        Text("Raffle ID  \(raffle.id)")
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
        Text("\(raffle.winnerId ?? -1)")
          .bold()
      }
      Text("Winner ID")
    }
  }
}

struct RaffleView_Previews: PreviewProvider {
  static var previews: some View {
    RaffleView().environmentObject(Raffle(id: 47, name: "Did you figure it out", createdAt: "2021-05-29T00:25:40.274Z", raffledAt: nil, winnerId: nil))
      .previewLayout(.sizeThatFits)
  }
}

