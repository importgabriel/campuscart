//
//  listingCard.swift
//  CampusCart
//
//  Created by wayne on 5/18/25.
//

import SwiftUI


struct listingCard: View {
    @State private var liked: Bool = false
    let activity: String
    let imageName: String
    var body: some View {
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)

                HeartButton(isLiked: $liked)
                    .padding(10)
                    .zIndex(1)
            }
            .frame(width: 200, height: 300)
        }
    }
        
    


struct scrollPreview: View {
    var body: some View {
 
            HStack{
                listingCard(activity: "listing", imageName: "sanford")
                
            }
    }
}


struct HeartButton: View {
    @Binding var isLiked: Bool

    var body: some View {
        Button(action: {
            isLiked.toggle()
            print("button pressed")
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
        }
        .contentShape(Rectangle())
    }
}


#Preview {
    scrollPreview()
}
