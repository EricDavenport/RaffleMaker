//
//  RaffleModel.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import Foundation

class Raffle: Codable, Identifiable, Equatable, ObservableObject {
  static func == (lhs: Raffle, rhs: Raffle) -> Bool {
    lhs.id == rhs.id
  }
  
  var id: Int
  var name: String
  var createdAt: String
  var raffledAt: String?
  var winnerId: Int?
  var secretToken: String?
  
  private enum CodingKeys: String, CodingKey {
    case id, name
    case createdAt = "created_at"
    case raffledAt = "raffled_at"
    case winnerId = "winner_id"
    case secretToken = "secret_token"
  }
  
  init(id: Int, name: String, createdAt: String, raffledAt: String?, winnerId: Int?) {
    self.id = id
    self.name = name
    self.createdAt = createdAt
    self.raffledAt = raffledAt
    self.winnerId = winnerId
  }
  
}

