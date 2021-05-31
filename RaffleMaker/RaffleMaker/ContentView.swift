//
//  ContentView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel = RaffleListVM()
  
  // presenting booleans
  @State private var newRaffleIsPresenting: Bool = false
  @State private var showingAlert: Bool = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.raffles) { rfl in
          RaffleView(raffle: rfl)
            .onTapGesture(perform: {
              self.showingAlert = true
            })
            .sheet(isPresented: $showingAlert, content: {
              DetailView()
//                .background(opacity(0.1))
            })
        }
        
      }
      .onAppear(perform: load)
      .navigationTitle("Ribble Raffle")
      .navigationBarItems(trailing: Button(action: {
        // TODO: add bool for showing add raffle view
        self.newRaffleIsPresenting = true
      }, label: {
        Image(systemName: "plus")
      }))
      .sheet(isPresented: $newRaffleIsPresenting, content: {
        NavigationView {
          NewRaffleView()
        }
      })
    }
  }
  
  private func load() {
    viewModel.loadRaffles()
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
