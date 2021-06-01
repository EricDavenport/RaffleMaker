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
    let expectedFirstRaffle = Raffle(id: 1, name: "Sample Raffle", createdAt: "2021-05-22T23:59:27.260Z", raffledAt: "2021-05-24T05:33:55.304Z", winnerId: 5)
    
    let exp = XCTestExpectation(description: "Fully loaded")
    
    do {
      RaffleAPIClient.loadAllRaffle { results in
        switch results {
        case .failure(let error):
          (XCTFail("Failed to load raffle list: \(error)"))
        case .success(let raffles):
          let sortedRaffles = raffles.sorted{ $0.id < $1.id}
          let actualFirstRaffle = sortedRaffles[0]
          XCTAssertEqual(expectedFirstRaffle, actualFirstRaffle, "They match")
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 5)
  }
  
  func testSingleRaffleLoad() {
    let expectedFirstRaffle = Raffle(id: 46, name: "Did you figure it out", createdAt: "2021-05-29T00:21:21.206Z", raffledAt: "2021-05-29T01:57:38.877Z", winnerId: 47)
    
    let exp = XCTestExpectation(description: "Raffle loaded")
    
    do {
      RaffleAPIClient.loadSingleRaffle(46) { result in
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
//  MARK: CreateTest
//        test works - commented out to avoid constant creation
  func testRaffleCreation() {

    let exp = XCTestExpectation(description: "raffle successfully posted")

    do {
      RaffleAPIClient.createRaffle("Did you figure it out", "L0ok5Lik3Y0uGotIt") { result in
        switch result {
        case .failure(let appError):
          XCTFail("Failed: \(appError)")
        case .success(let facts):
          XCTAssertTrue(facts, "Successfully posted - Check postman")
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 5)
  }
  
  func testAddParticipant() {
    let exp = XCTestExpectation(description: "Successfully added participant to raffle")
    
    do {
      RaffleAPIClient.addParticipant(46, firstName: "Eric", lastname: "D2", email: "ed2@email.com", phone: nil) { result in
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
      RaffleAPIClient.loadParticipants(46) { result in
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
  
  func testSelectWinner() {
    let exp = XCTestExpectation(description: "Successfully selected a winner")
    
    do {
      RaffleAPIClient.selectWinner("L0ok5Lik3Y0uGotIt", 46) { result in
        switch result {
        case .failure(let appError):
          XCTFail("Failed to selecta winner - this isn;t the correct way:\(appError)")
        case .success(let facts):
          XCTAssertTrue(facts)
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 10)
  }
  
  func testLoadWinner() {
    let expectedWinner = Participant(id: 47, raffleId: 46, firstName: "Eric", lastName: "D", email: "ed@email.com", phone: nil, registeredAt: "2021-05-29T00:55:18.123Z")
    
    let exp = XCTestExpectation(description: "Winner successfully loaded")
    
    do {
      RaffleAPIClient.loadWinner(46) { result in
        switch result {
        case .failure(let appError):
          XCTFail("Failed to load winner: \(appError)")
        case .success(let winner):
          XCTAssertEqual(expectedWinner, winner)
          exp.fulfill()
        }
      }
    }
    wait(for: [exp], timeout: 10)
  }
  
  
}

