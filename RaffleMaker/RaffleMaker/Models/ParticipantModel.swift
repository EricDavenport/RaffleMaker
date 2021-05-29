//
//  ParticipantModel.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import Foundation

struct Participant: Codable, Identifiable, Equatable {
  let id: Int
  let raffleId: Int
  let firstName: String
  let lastName: String
  let email: String
  let phone: String?
  let registeredAt: String
  
  private enum CodingKeys: String, CodingKey {
    case id, email, phone
    case raffleId = "raffle_id"
    case firstName = "firstname"
    case lastName = "lastname"
    case registeredAt = "registered_at"
  }
  
  
  
}

/*
 {
     "id": 5,
     "raffle_id": 1,
     "firstname": "Marvin",
     "lastname": "Bosco",
     "email": "Arlene8@yahoo.com",
     "phone": null,
     "registered_at": "2021-05-23T00:03:17.232Z"
 }
 */
