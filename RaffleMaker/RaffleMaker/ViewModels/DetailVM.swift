//
//  DetailVM.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/30/21.
//

import Foundation
import SwiftUI

class DetailVM: ObservableObject {
  @Published var raffle = Raffle(id: 0, name: "", createdAt: "", raffledAt: nil, winnerId: nil)
  @Published var participants = [Participant]()
  var isPresenting = false
  
  func loadRaffle(_ raffledId: Int) {
    RaffleAPIClient.loadSingleRaffle(raffledId) { result in
      switch result {
      case .failure:
        break
      case .success(let raffle):
        DispatchQueue.main.async {
          self.raffle = raffle
        }
      }
    }
  }
  
  func loadParticipants(_ raffleId: Int) {
    RaffleAPIClient.loadParticipants(raffleId) { result in
      switch result {
      case .failure:
        break
      case .success(let participants):
        DispatchQueue.main.async {
          self.participants = participants.sorted { $0.registeredAt < $1.registeredAt}
        }
      }
    }
  }
  
  
  
  
  
}
