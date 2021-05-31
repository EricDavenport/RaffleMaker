//
//  DetailView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/30/21.
//

import SwiftUI

struct DetailView: View {
  
  
  @State var rafID = 46
  var secretToken = ""
  @State var userInput = ""
  @State var participants = [Participant]()
  @ObservedObject var detailViewModel = DetailVM()
  @State var winnerSelected = false
  
  var body: some View {
    VStack {
      Text("\(detailViewModel.raffle.name)")
      WinnerSelected(winnerId: .constant(detailViewModel.raffle.winnerId ?? -2), winnerSelected: $winnerSelected)
      WinnerPartiButton(raffleId: .constant(detailViewModel.raffle.id), raffleName: .constant(detailViewModel.raffle.name), secretToken: .constant(userInput), winnerSelected: winnerSelected)
      Divider()
      TextField("Secret Token", text: $userInput)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Section {
        List {
          Section(header: Text("Participants: \(participants.count)")) {
            ForEach(detailViewModel.participants) { participant in
              ParticipantView(participant: .constant(participant))
            }
          }
          .listStyle(InsetGroupedListStyle())
        }
      }
    }
    .onAppear(perform: loadRaffle)
  }
  
  private func loadRaffle() {
    detailViewModel.loadRaffle(rafID)
    detailViewModel.loadParticipants(rafID)
  }
  
  private func isSecretCorrect() -> Bool {
    return secretToken == userInput
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView()
  }
}
