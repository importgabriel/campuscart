//
//  marketPlacePage.swift
//  CampusCart
//
//  Created by wayne on 5/18/25.
//

import SwiftUI

struct marketPlacePage: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<8, id: \.self) { index in
                    listingCard(imageName: "sanford")
                }
            }
            .padding()
        }
    }
}

#Preview {
    TopBar(title: "MarketPlace")
    marketPlacePage()
}
