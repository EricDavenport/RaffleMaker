//
//  RaffleAPIClient.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import Foundation

struct RaffleAPClient {
  
  
  /// <#Description#>
  /// - Parameter completion: <#completion description#>
  /// - Returns: <#description#>
  static func loadAllRaffle(completion: @escaping (Result<[Raffle], AppError>) -> ()) {
    
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles"
    
    // create url from the string(above)
    guard let url = URL(string: endpointString) else {
      completion(.failure(.badURL(endpointString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let error):
        completion(.failure(.networkClientError(error)))
      case .success(let data):
        do {
          let raffles = try JSONDecoder().decode([Raffle].self, from: data)
          completion(.success(raffles))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  
  /// <#Description#>
  /// - Parameters:
  ///   - id: <#id description#>
  ///   - completion: <#completion description#>
  /// - Returns: <#description#>
  static func loadSingleRaffle(_ id: Int, completion: @escaping (Result<Raffle, AppError>) -> ()) {
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)"
    
    guard let url = URL(string: endpointString) else {
      completion(.failure(.badURL(endpointString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { result in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let raffle = try JSONDecoder().decode(Raffle.self, from: data)
          completion(.success(raffle))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  
  
  /// Load all participants for a specified raffle
  /// - Parameters:
  ///   - id: <#id description#>
  ///   - completion: <#completion description#>
  /// - Returns: <#description#>
  static func loadParticipants(_ id: Int, completion: @escaping (Result<[Participant], AppError>) -> ()) {
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/participants"
  
    guard let url = URL(string: endpointString) else {
      completion(.failure(.badURL(endpointString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { result in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let participants = try JSONDecoder().decode([Participant].self, from: data)
          completion(.success(participants))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  
  
  /// <#Description#>
  /// - Parameters:
  ///   - id: <#id description#>
  ///   - completion: <#completion description#>
  /// - Returns: <#description#>
  static func loadWinner(_ id: Int, completion: @escaping (Result<Participant, AppError>) -> ()) {
    let endpointURLString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/winner"
    
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { result in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let participant = try JSONDecoder().decode(Participant.self, from: data)
          completion(.success(participant))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  

  
  /// <#Description#>
  /// - Parameters:
  ///   - name: <#name description#>
  ///   - secretToken: <#secretToken description#>
  ///   - completion: <#completion description#>
  /// - Returns: <#description#>
  static func createRaffle(_ name: String, _ secretToken: String, completion: @escaping (Result<Bool, AppError>) -> ()) {
    let raffle = ["name": name, "secret_token": secretToken]
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles"
    
    guard let url = URL(string: endpointString) else {
      completion(.failure(.badURL(endpointString)))
      return
    }
    
    do {
      let data = try JSONEncoder().encode(raffle)
      
      var request = URLRequest(url: url)
      
      request.httpMethod = "POST"
      
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
      request.httpBody = data
      
      NetworkHelper.shared.performDataTask(with: request) { result in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success:
          completion(.success(true))
        }
      }
    } catch {
      completion(.failure(.encodingError(error)))
    }
  }
  
  /// Add participant to selected raffle
  /// - Parameters:
  ///   - id: id of the raffle the particiapant is being added to
  ///   - firstName: First name of participant
  ///   - lastname: Last name of participant being added
  ///   - email: Email of participant being added
  ///   - phone: (Optional) Participant's phone number
  ///   - completion: Completion handler used to handle errors and completion what result being received
  /// - Returns: Boolean if the participant was able to be added to the raffle or not, or custom AppError enum used for handling erros recieved from network calls
  static func addParticipant(_ id: Int, firstName: String, lastname: String, email: String, phone: String?,
                             completion: @escaping (Result<Bool, AppError>) -> ()) {
    
    let participant = ["firstname": firstName, "lastname": lastname, "email": email, "phone": phone]
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/participants"
    
    guard let url = URL(string: endpointString) else {
      completion(.failure(.badURL(endpointString)))
      return
    }
    
    do {
      let data = try JSONEncoder().encode(participant)
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = data
      
      NetworkHelper.shared.performDataTask(with: request) { result in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success:
          completion(.success(true))
        }
      }
    } catch {
      completion(.failure(.encodingError(error)))
    }
  }
  
  /// When this function is called a random winner for the raffle will be selected
  /// - Parameters:
  ///   - secretToken: <#secretToken description#>
  ///   - id: <#id description#>
  ///   - completion: <#completion description#>
  /// - Returns: <#description#>
  static func selectWinner(_ secretToken: String, _ id: Int, completion: @escaping (Result<Bool, AppError>) -> ()) {
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/winner"
    
    guard let url = URL(string: endpointString) else {
      completion(.failure(.badURL(endpointString)))
      return
    }
    
    do {
      let tokenData = ["secret_token": secretToken]
      let data = try JSONEncoder().encode(tokenData)
      
      var request = URLRequest(url: url)
      request.httpMethod = "PUT"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = data
      
      NetworkHelper.shared.performDataTask(with: request) { result in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success:
          completion(.success(true))
        }
      }
    } catch {
      completion(.failure(.encodingError(error)))
    }
  }
  
}
