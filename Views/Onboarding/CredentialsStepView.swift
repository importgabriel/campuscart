//
//  CredentialsStepView.swift
//  CampusCart
//
//  Created by wayne on 5/21/25.
//


// Views/Onboarding/CredentialsStepView.swift

import SwiftUI

struct CredentialsStepView: View {
    @Binding var email: String
    @Binding var password: String
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Your Account")
                .font(.headline)

            TextField("Email (.edu only)", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Next") {
                onNext()
            }
            .disabled(
               !email.lowercased().hasSuffix(".edu")
               || password.count < 6
            )
            .buttonStyle(.borderedProminent)
        }
    }
}
