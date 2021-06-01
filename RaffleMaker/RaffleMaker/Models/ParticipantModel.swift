//
//  ParticipantModel.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import Foundation

/// Participant model all values required excluding phone number when adding new particiants to a raffle
struct Participant: Codable, Identifiable, Equatable {
  var id: Int
  var raffleId: Int
  var firstName: String
  var lastName: String
  var email: String
  var phone: String?
  var registeredAt: String
  
  private enum CodingKeys: String, CodingKey {
    case id, email, phone
    case raffleId = "raffle_id"
    case firstName = "firstname"
    case lastName = "lastname"
    case registeredAt = "registered_at"
  }
  
  init(id: Int, raffleId: Int, firstName: String, lastName: String, email: String, phone: String?, registeredAt: String) {
    self.id = id
    self.raffleId = raffleId
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.phone = phone
    self.registeredAt = registeredAt
  }
  
  
}
