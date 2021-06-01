//
//  ParticipantView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/31/21.
//

import SwiftUI

struct ParticipantView: View {
  @Binding var participant: Participant
  
  
  var body: some View {
    VStack {
      Text("\(participant.firstName) \(participant.lastName)")
        .padding(5)
      Text("\(participant.email)")
      Text("\(participant.phone ?? "")")
    }
    .offset(x: -10)
    .frame(width: 400)
  }
}

struct ParticipantView_Previews: PreviewProvider {
  static var previews: some View {
    ParticipantView(participant: .constant(Participant(id: 47, raffleId: 45, firstName: "Eric", lastName: "Davenport", email: "someoneNew@gmail.com", phone: "(646) 934-3464", registeredAt: "2021-05-31T18:22:34.901Z")))
  }
}
