//
//  RaffleMakerTests.swift
//  RaffleMakerTests
//
//  Created by Eric Davenport on 5/28/21.
//

import XCTest
@testable import RaffleMaker

class RaffleMakerTests: XCTestCase {

  func testAllLoad() {
    // arrange
    let expectedFirstRaffle = Raffle(id: 8, name: "My first Raffle", createdAt: "2021-05-28T14:50:27.189Z", raffledAt: nil, winnerId: nil)
    
    let exp = XCTestExpectation(description: "Fully loaded")
    
    do {
      RaffleAPClient.loadAllRaffle { results in
        switch results {
        case .failure(let error):
          (XCTFail("Failed to load raffle list: \(error)"))
        case .success(let raffles):
          let actualFirstRaffle = raffles[0]
          XCTAssertEqual(expectedFirstRaffle, actualFirstRaffle, "They match")
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 5)
  }
  
  func testSingleRaffleLoad() {
    let expectedFirstRaffle = Raffle(id: 46, name: "Did you figure it out", createdAt: "2021-05-29T00:21:21.206Z", raffledAt: nil, winnerId: nil)
    
    let exp = XCTestExpectation(description: "Raffle loaded")
    
    do {
      RaffleAPClient.loadSingleRaffle(46) { result in
        switch result {
        case .failure(let appError):
          XCTFail("Failed to load correct raffle \(appError)")
        case .success(let raffle):
          XCTAssertEqual(raffle, expectedFirstRaffle, "Single call still working properly")
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 5)
  }
  //MARK: CreateTest
  //      test works - commented out to avoid constant creation
//  func testRaffleCreation() {
//
//    let exp = XCTestExpectation(description: "raffle successfully posted")
//
//    do {
//      RaffleAPClient.createRaffle("Did you figure it out", "L0ok5Lik3Y0uGotIt") { result in
//        switch result {
//        case .failure(let appError):
//          XCTFail("Failed: \(appError)")
//        case .success(let facts):
//          XCTAssertTrue(facts, "Successfully posted - Check postman")
//          exp.fulfill()
//        }
//      }
//    }
//    wait(for: [exp], timeout: 5)
//  }
  
  func testAddParticipant() {
    let exp = XCTestExpectation(description: "Successfully added participant to raffle")
    
    do {
      RaffleAPClient.addParticipant(46, firstName: "Eric", lastname: "D2", email: "ed2@email.com", phone: nil) { result in
        switch result {
        case .failure(let error):
          XCTFail("Failed to add participant: \(error)")
        case .success(let facts):
          XCTAssertTrue(facts)
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 5)
  }
  
  // TODO: What to assert this value versus -> load all particpants function
  func testLoadParticipanta() {
    let exp = XCTestExpectation(description: "Successfully loaded participant list")

    do {
      RaffleAPClient.loadParticipants(46) { result in
        switch result {
        case .failure(let appError):
          XCTFail("Failed to load participant list: \(appError)")
        case .success(let participants):
          XCTAssertGreaterThan(participants.count, -1)
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 5)
  }
  
  
}

