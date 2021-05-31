//
//  NewParticipantView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/31/21.
//

import SwiftUI

struct NewParticipantView: View {
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var email = ""
  @State private var phone = ""
  @Binding var raffleId: Int
  
  var body: some View {
    VStack {
      Form {
        TextField("First Name", text: $firstName)
        TextField("Last Name", text: $lastName)
        TextField("Email", text: $email)
        TextField("Phone number (Optional)", text: $phone)
      }
      HStack {
        Button(action: {
          addNewParticipant()
        }, label: {
          Text("Save")
        })
        .buttonStyle(MainButton(color: .green))
        Button(action: {
          clear()
        }, label: {
          Text("Clear")
        })
        .buttonStyle(MainButton(color: .blue))
      }
    }
  }
  
  private func addNewParticipant() {
    var optionalNumber: String? {
      if phone == "" {
        return nil
      } else {
        return phone
      }
    }
    RaffleAPIClient.addParticipant(raffleId, firstName: firstName, lastname: lastName, email: email, phone: optionalNumber) { result in
      switch result {
      case .failure(let appError):
        // TODO: present alert of failure
        print("failed to add participant:\(appError)")
      case .success:
        // TODO: Alert showing success
        print("successully added participant")
      }
    }
  }
  
  private func clear() {
    firstName = ""
    lastName = ""
    email = ""
    phone = ""
  }
}

struct NewParticipantView_Previews: PreviewProvider {
  static var previews: some View {
    NewParticipantView(raffleId: .constant(46))
  }
}
