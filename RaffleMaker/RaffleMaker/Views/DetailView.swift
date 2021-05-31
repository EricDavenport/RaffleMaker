//
//  DetailView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/30/21.
//

import SwiftUI

struct DetailView: View {
  
  @State var rafID = 46
  //  @State var raffle = Raffle(id: -1, name: "", createdAt: "", raffledAt: nil, winnerId: nil)
  @State var participants = [Participant]()
  @ObservedObject var detailViewModel = DetailVM()
  
  var body: some View {
    VStack {
      Text("\(detailViewModel.raffle.name)")
      Text("\(detailViewModel.raffle.id)")
      
      Section {
        List {
          Section(header: Text("Participants")) {
            ForEach(detailViewModel.participants) { participant in
              VStack {
                HStack {
                  Text("\(participant.firstName) \(participant.lastName)")
                  Text("\(participant.raffleId)")
                }
                Text("\(participant.email)")
                Text("\(participant.phone ?? "No number")")
              }
            }
          }
        }
      }
    }
    .onAppear(perform: loadRaffle)
  }
  
  private func clear() {
    
  }
  
  private func loadRaffle() {
    detailViewModel.loadRaffle(rafID)
    detailViewModel.loadParticipants(rafID)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView()
  }
}
