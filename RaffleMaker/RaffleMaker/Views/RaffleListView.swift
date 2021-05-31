//
//  ContentView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import SwiftUI

struct RaffleListView: View {
  
  @ObservedObject var viewModel = RaffleListVM()
  @ObservedObject var raffleAPI = RaffleAPIClient()
  @State private var currentID = 0
  @State private var search = ""
  @State private var newRaffleIsPresenting: Bool = false
  @State private var showingAlert: Bool = false
  
  var body: some View {
    NavigationView {
      List {
        TextField("Search Name", text: $search)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        ForEach(raffleAPI.raffles) { rfl in
          NavigationLink(destination: DetailView(rafID: rfl.id, secretToken: rfl.secretToken ?? "", winnerSelected: (rfl.winnerId != nil) ? true : false)) {
            RaffleView(raffle: rfl)
          }
        }
        
      }
      .onAppear(perform: load)
      .navigationBarItems(trailing: Button(action: {
        newRaffleIsPresenting = true
      }, label: {
        Text("New Raffle")
      }))
      .sheet(isPresented: $newRaffleIsPresenting, content: {
        NewRaffleView(isPresenting: $newRaffleIsPresenting)
      })
      .navigationTitle("Ribble Raffle")
    }
  }
  
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
