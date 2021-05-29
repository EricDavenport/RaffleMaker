//
//  ContentView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import SwiftUI

struct ContentView: View {
  @State private var raffles: [Raffle] = []
  
  private func loadRaffles() {
    RaffleAPClient.loadAllRaffle { results in
      switch results {
      case .failure(let error):
        print(error)
      case .success(let raffles):
        self.raffles = raffles
      }
    }
  }
  
  
  
  
  var body: some View {
  
    List {
//      ForEach(raffle)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
//  var raffles: [Raffle]


  static var previews: some View {
    ContentView()
  }
}
