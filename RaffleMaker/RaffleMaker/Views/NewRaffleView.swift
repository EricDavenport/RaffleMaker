//
//  NewRaffleView.swift
//  RaffleMaker
//
//  Created by Eric Davenport on 5/30/21.
//

import SwiftUI

struct NewRaffleView: View {
  // var to control state of current sheet(view)
//  @Environment(\.presentationMode) var presentationMode
  
  @Binding var isPresenting: Bool
  @State private var raffleName: String = ""
  @State private var secretToken: String = ""
  
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
              isPresenting = false
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
    NewRaffleView(isPresenting: .constant(false))
  }
}


/*
 
 struct DismissingView1: View {
     @Environment(\.presentationMode) var presentationMode

     var body: some View {
         Button("Dismiss Me") {
             presentationMode.wrappedValue.dismiss()
         }
     }
 }

 struct ContentView: View {
     @State private var showingDetail = false

     var body: some View {
         Button("Show Detail") {
             showingDetail = true
         }
         .sheet(isPresented: $showingDetail) {
             DismissingView1()
         }
     }
 }
 */
