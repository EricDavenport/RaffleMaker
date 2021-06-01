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
  @State var needRefresh = false
  
  var body: some View {
    VStack {
      WinnerSelected(winnerId: .constant(detailViewModel.raffle.winnerId ?? -2), winnerSelected: $winnerSelected)
      WinnerPartiButton(raffleId: .constant(detailViewModel.raffle.id), raffleName: .constant(detailViewModel.raffle.name), secretToken: .constant(userInput), winnerSelected: winnerSelected, needsRefresh: $needRefresh)
        .onAppear(perform: loadRaffle)
      Divider()
      TextField("Secret Token", text: $userInput)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Section {
        List {
          Section(header: Text("Participants")) {
            ForEach(detailViewModel.participants) { participant in
              ParticipantView(participant: .constant(participant))
            }
          }
          .onAppear(perform: loadRaffle)
          .listStyle(DefaultListStyle())
        }
        
      }
      
    }
    .onAppear(perform: loadRaffle)
    .navigationTitle("\(detailViewModel.raffle.name)")
  }
  
  private func loadRaffle() {
    detailViewModel.loadRaffle(rafID)
    detailViewModel.loadParticipants(rafID)
    print(needRefresh)
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
