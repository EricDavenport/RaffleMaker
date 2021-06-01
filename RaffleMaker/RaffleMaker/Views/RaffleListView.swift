//
//  ContentView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import SwiftUI

struct RaffleListView: View {
  
  @ObservedObject var raffleAPI = RaffleAPIClient()
  @State private var currentID = 0
  @State private var search = ""
  @State private var newRaffleIsPresenting: Bool = false
  @State var showingAlert: Bool = false
  @State var needsRefresh = false
  @State var created = false
  
  var body: some View {
    NavigationView {
      List {
        TextField("Search Name", text: $search)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        ForEach(raffleAPI.raffles) { rfl in
          NavigationLink(destination: DetailView(secretToken: rfl.secretToken ?? "", rafID: rfl.id,  winnerSelected: (rfl.winnerId != nil) ? true : false)) {
            RaffleView(raffle: rfl)
            
          }
        }
        .onAppear(perform: load)
      }
      .onAppear(perform: load)
      .navigationBarItems(trailing: Button(action: {
        newRaffleIsPresenting = true
      }, label: {
        Text("New Raffle")
      }))
      .sheet(isPresented: $newRaffleIsPresenting, content: {
        NewRaffleView(isPresenting: $newRaffleIsPresenting, needsRefresh: $needsRefresh, showAlert: $showingAlert, created: $created)
      })
      .navigationTitle("Ribble Raffle")
      // TODO: add alert + boolean for showing completion vs failure
    }
    .onAppear(perform: load)
  }
  
  /// Function checks if new the newRaffleView screen is still present if false reloads the array of raffles to update UI
  private func load() {
    if newRaffleIsPresenting == false {
      raffleAPI.fetchRaffles()
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RaffleListView()
  }
}
