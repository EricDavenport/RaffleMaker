//
//  ContentView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/28/21.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel = RaffleListVM()
  
  var body: some View {
    
    List {
      ForEach(viewModel.raffles) { rfl in
        Text("\(rfl.name)")
      }
    }.onAppear(perform: load)
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
