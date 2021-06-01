//
//  NewRaffleView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/30/21.
//

import SwiftUI

struct NewRaffleView: View {
  
  @Binding var isPresenting: Bool
  @State private var raffleName: String = ""
  @State private var secretToken: String = ""
  @Binding var needsRefresh: Bool
  @Binding var showAlert: Bool
  @Binding var created: Bool
  
  var body: some View {
    Form {
      Section(header: Text("Create a new Raffle")) {
        TextField("Raffle Name", text: $raffleName)
        TextField("Secret Token", text: $secretToken)
      }
      HStack {
        Spacer()
        Button(action: {
          RaffleAPIClient.createRaffle(raffleName, secretToken) { result in
            switch result {
            case .failure:
              break
            case .success(let pass):
              if pass {
                created = true
                isPresenting = false
                needsRefresh = true
                showAlert = true
              }
            }
          }
        }, label: {
          Text("Create")
        })
        Spacer()
      }
    }
  }
}
  
  struct NewRaffleView_Previews: PreviewProvider {
    static var previews: some View {
      NewRaffleView(isPresenting: .constant(false), needsRefresh: .constant(false), showAlert: .constant(false), created: .constant(false))
    }
  }

