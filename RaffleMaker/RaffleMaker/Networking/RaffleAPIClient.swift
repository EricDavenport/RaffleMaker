//
//  RaffleAPIClient.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import Foundation

class RaffleAPIClient: ObservableObject {
  
  @Published var raffles = [Raffle]()
  
  func filterRaffles(search: String) {
    raffles = raffles.filter { $0.name.contains(search)}
  }
  
  func fetchRaffles() {
    let endpointString = "https://raffle-fs-app.herokuapp.com/api/raffles"
    
    // create url from the string(above)
    guard let url = URL(string: endpointString) else {
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure:
        break
      case .success(let data):
        do {
          let rafflesLoaded = try JSONDecoder().decode([Raffle].self, from: data)
          DispatchQueue.main.async {
            self.raffles = rafflesLoaded.sorted { $0.id < $1.id }
          }
          
        } catch {
          //          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  
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
          let rafflesLoaded = try JSONDecoder().decode([Raffle].self, from: data)
          completion(.success(rafflesLoaded))
          
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  
  /// Function used to load single raffle if not all raffles are needed
  /// - Parameters:
  ///   - id: ID number of the raffle to be loaded
  ///   - completion: escaping closure used  tp allow raffles loaded too populate a property
  /// - Returns: @escaping closure -> results return after function completes escaping is the raffles
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
  ///   - id: ID number for a specific raffle in order to load all participants - used in URL
  ///   - completion: @escaping closiure delivering the set of participants
  /// - Returns: if completes delivers array of Participannts or AppErro if fail
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
  
  
  /// Loads the winner of the given raffle if one exist
  /// - Parameters:
  ///   - id: ID of the raffle that is being checked for a winner
  ///   - completion: @escaping cloure value given outside of func closure allows func to compile withouterrors
  /// - Returns: Return a single participant after the func compiles and completes
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
  
  
  
  /// Used in order to create a new raffl
  /// - Parameters:
  ///   - name: Required property for creating new raffle(String)
  ///   - secretToken: Required string Property in order to corretly make a new raffle String of any value
  ///   - completion: @escaping closure as the closure should finish after the function finishes
  /// - Returns: Returns a Boolean value if successfully able to crteate a new raffle or not
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
  ///   - secretToken: User input String value to check if the current user can run the select winner operation
  ///   - id: ID of the raffle to load in order to obtain the secret token
  ///   - completion: @escaping closure allowing func to complete after compiling
  /// - Returns: returns a Boolean value afterwards if the secretToken was correct and a winner was selected
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
