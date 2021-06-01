//
//  DetailView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/30/21.
//

import SwiftUI

struct DetailView: View {
  
  var secretToken = ""
  @ObservedObject var detailViewModel = DetailVM()
  @State var rafID = 46
  @State var userInput = ""
  @State var participants = [Participant]()
  @State var winnerSelected = false
  @State var needRefresh = false
  
  var body: some View {
    VStack {
      WinnerSelected(winnerId: .constant(detailViewModel.raffle.winnerId ?? -2), winnerSelected: $winnerSelected)
      WinnerPartiButton(raffleId: .constant(detailViewModel.raffle.id), raffleName: .constant(detailViewModel.raffle.name), secretToken: .constant(userInput), winnerSelected: winnerSelected, needsRefresh: $needRefresh)
        .onAppear(perform: updateUI)
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
          .onAppear(perform: updateUI)
          .listStyle(DefaultListStyle())
        }
      }
    }
    .onAppear(perform: updateUI)
    .navigationTitle("\(detailViewModel.raffle.name)")
  }
  
  /// function called when the UI needs to update. In order to change UI the Observed variable needs to be updated
  private func updateUI() {
    detailViewModel.loadRaffle(rafID)
    detailViewModel.loadParticipants(rafID)
    print(needRefresh)
  }
  
  /// Helper function to compare the userInput to the prepopulated secretToken
  /// - Returns: Boolean if the two values match or not
  private func isSecretCorrect() -> Bool {
    return secretToken == userInput
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView()
  }
}
