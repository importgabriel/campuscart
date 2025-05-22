//
//  MajorStepView.swift
//  CampusCart
//
//  Created by wayne on 5/21/25.
//


// Views/Onboarding/MajorStepView.swift

import SwiftUI

struct MajorStepView: View {
    @Binding var major: String
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What’s your major?")
                .font(.headline)
            
            TextField("Major", text: $major)
                .textFieldStyle(.roundedBorder)
            
            Button("Next") {
                onNext()
            }
            .disabled(major.isEmpty)
            .buttonStyle(.borderedProminent)
        }
    }
}
