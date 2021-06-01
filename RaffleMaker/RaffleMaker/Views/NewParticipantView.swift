//
//  NewParticipantView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/31/21.
//

import SwiftUI

struct NewParticipantView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var email = ""
  @State private var phone = ""
  @Binding var raffleId: Int
  @Binding var isPresenting: Bool
  @State private var showAlert = false
  @State private var successAlert = false
  @Binding var needRefresh: Bool
  @State private var failedAlertShow = false
  @State private var appErrorToShow = ""
  
  var body: some View {
    VStack {
      Form {
        Section(header: Text("Enter new participant information")) {
          TextField("First Name", text: $firstName)
          TextField("Last Name", text: $lastName)
          TextField("Email", text: $email)
        }
        Section(header: Text("Optional")) {
          TextField("Phone number", text: $phone)
        }
      }
      HStack {
        Button(action: {
          addNewParticipant()
          showAlert = true
          isPresenting.toggle()
          needRefresh.toggle()
        }, label: {
          Text("Save")
        })
        .buttonStyle(MainButton(color: .green))
        
        Button(action: {
          clear()
        }, label: {
          Text("Clear")
            .cornerRadius(2.0)
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
        
        failedAlertShow = true
        print("failed to add participant:\(appError)")
      case .success:
        DispatchQueue.main.async {
          // TODO: Alert showing success
          self.showAlert = true
        }
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
    NewParticipantView(raffleId: .constant(46), isPresenting: .constant(false), needRefresh: .constant(false))
  }
}
