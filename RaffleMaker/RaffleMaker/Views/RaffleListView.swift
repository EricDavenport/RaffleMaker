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
  @State var showingAlert: Bool = false
  @State var needsRefresh = false
  @State var created = false
  
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
        .onAppear(perform: load)
      }
      .onAppear(perform: load)
      .navigationBarItems(trailing: Button(action: {
        newRaffleIsPresenting = true
      }, label: {
        Text("New Raffle")
      }))
//      .alert(isPresented: $showingAlert, content: {
//        Alert(title: Text("\(created ? "Success" : "Failed")"), message: Text("\(created ? "Raffle Created" : "Unable to create raffle please retry")"), dismissButton: .none)
//
//      })
      .sheet(isPresented: $newRaffleIsPresenting, content: {
        NewRaffleView(isPresenting: $newRaffleIsPresenting, needsRefresh: $needsRefresh, showAlert: $showingAlert, created: $created)
      })
      .navigationTitle("Ribble Raffle")
    }
    .onAppear(perform: load)
  }
  
  private func load() {
    if newRaffleIsPresenting == false {
      raffleAPI.fetchRaffles()
    }
    print("loda0ed")
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RaffleListView()
  }
}
