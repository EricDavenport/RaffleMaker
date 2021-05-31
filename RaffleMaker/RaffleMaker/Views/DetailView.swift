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
  
  var body: some View {
    VStack {
      Text("\(detailViewModel.raffle.name)")
      Text("\(detailViewModel.raffle.id)")
      Image(systemName: "star")
      Divider()
      WinnerPartiButton(raffleId: .constant(detailViewModel.raffle.id), raffleName: .constant(detailViewModel.raffle.name), secretToken: .constant(userInput))
        .frame(height: 200)
      Divider()
      TextField("Secret Token", text: $userInput)
        .padding()
      Section {
        List {
          Section(header: Text("Participants: \(participants.count)")) {
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
