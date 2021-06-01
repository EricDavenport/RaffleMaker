//
//  WinnerSelect+ParticipantAdd.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/31/21.
//

import SwiftUI

struct WinnerPartiButton: View {
  @Environment(\.colorScheme) var colorScheme
  
  @Binding var raffleId: Int
  @Binding var raffleName: String
  @State private var newParIsShowing = false
  @Binding var secretToken: String
  @State var winnerSelected: Bool
  @Binding var needsRefresh: Bool
  
  var body: some View {
    HStack {
      Button(action: {
        RaffleAPIClient.selectWinner(secretToken, raffleId) { result in
          switch result {
          case .failure:
            print("winner not selected")
          case .success:
            print("winner selected")
            winnerSelected = true
          }
        }
      }, label: {
        Text("Select Winner")
          .foregroundColor(colorScheme == .dark ? Color.red : Color.black)
      })
      .buttonStyle(MainButton(color: .red))
      Button(action: {
        self.newParIsShowing = true
      }, label: {
        Text("New Participant")
          .foregroundColor(colorScheme == .dark ? Color.black : Color.black)
        
      })
      .buttonStyle(MainButton(color: .black))
      .sheet(isPresented: $newParIsShowing, content: {
        NewParticipantView(raffleId: $raffleId, isPresenting: $newParIsShowing, needRefresh: $needsRefresh)
      })
    }
    
    .padding()
    .frame(height: 70)
  }
}

struct WinnerSelect_ParticipantAdd_Previews: PreviewProvider {
  static var previews: some View {
    WinnerPartiButton(raffleId: .constant(46), raffleName: .constant("New Raffle"), secretToken: .constant("new token"), winnerSelected: false, needsRefresh: .constant(false))
      .previewLayout(.sizeThatFits)
  }
}
