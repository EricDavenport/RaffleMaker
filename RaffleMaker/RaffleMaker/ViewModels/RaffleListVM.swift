//
//  RaffleListVM.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/29/21.
//

import Foundation
import SwiftUI

class RaffleListVM: ObservableObject {
  @Published var raffles: [Raffle] = []
//  @Published var singleRaffle: Raffle
  
  func loadRaffles() {
    RaffleAPIClient.loadAllRaffle { result in
      switch result {
      case .failure:
        print("failed to load")
      case .success(let raffles):
        DispatchQueue.main.async {
          self.raffles = raffles
        }
      }
    }
  }
  
//  func loadOne() {
//    RaffleAPClient.loadSingleRaffle(46) { result in
//      switch result {
//      case .failure(let error):
//        print("error: \(error)")
//      case .success(let _):
//        self.singleRaffle = raffle
//      }
//    }
//  }
  
}
