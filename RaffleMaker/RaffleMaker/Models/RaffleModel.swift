//
//  RaffleModel.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import Foundation

struct Raffle: Codable, Identifiable, Equatable {
  let id: Int
  let name: String
  let createdAt: String
  let raffledAt: String?
  let winnerId: Int?
  
  private enum CodingKeys: String, CodingKey {
    case id, name
    case createdAt = "created_at"
    case raffledAt = "raffled_at"
    case winnerId = "winner_id"
  }
  
}

