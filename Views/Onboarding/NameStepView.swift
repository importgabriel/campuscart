//
//  NameStepView.swift
//  CampusCart
//
//  Created by wayne on 5/21/25.
//

// NameStepView.swift

import SwiftUI

struct NameStepView: View {
  @Binding var name: String
  let onNext: () -> Void

  var body: some View {
    VStack(spacing: 20) {
      Text("What’s your full name?")
        .font(.headline)

      TextField("Full Name", text: $name)
        .textFieldStyle(.roundedBorder)

      Button("Next") {
        onNext()
      }
      .disabled(name.isEmpty)
      .buttonStyle(.borderedProminent)
    }
  }
}



