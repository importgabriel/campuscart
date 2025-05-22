//
//  YearStepView.swift
//  CampusCart
//
//  Created by wayne on 5/21/25.
//


// Views/Onboarding/YearStepView.swift

import SwiftUI

struct YearStepView: View {
    @Binding var year: String
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What’s your graduation year?")
                .font(.headline)
            
            TextField("e.g. 2026", text: $year)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            Button("Next") {
                onNext()
            }
            .disabled(Int(year) == nil)
            .buttonStyle(.borderedProminent)
        }
    }
}
