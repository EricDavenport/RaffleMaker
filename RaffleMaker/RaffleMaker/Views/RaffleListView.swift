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
  
  // presenting booleans
  @State private var newRaffleIsPresenting: Bool = false
  @State private var showingAlert: Bool = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(raffleAPI.raffles) { rfl in
          RaffleView(raffle: rfl)
            .onTapGesture {
              self.showingAlert = true
              self.currentID = rfl.id
            }
            .sheet(isPresented: $showingAlert, content: {
              DetailView(rafID: currentID)
            })
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
