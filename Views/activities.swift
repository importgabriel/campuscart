//
//  activities.swift
//  CampusCart
//
//  Created by wayne on 5/18/25.
//

import SwiftUI


struct largeActivityCard: View {
    let activity: String
    let imageName: String
    var body: some View {
        ZStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width:375, height: 175)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(radius:5)
                .overlay(
                    RoundedRectangle(cornerRadius:40)
                        .foregroundStyle(Color.gray)
                        .opacity(0.5)
                )
                .overlay(
                    Text(activity)
                        .foregroundStyle(Color.white)
                    )
            
          
            
        }
      
        .frame(width: 350, height: 150)
        .background(Color.white)

    }
}

struct smallActivityCard: View {
    let activity: String
    let imageName: String
    var body: some View {
        ZStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width:175, height: 175)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:5)
                .overlay(
                    RoundedRectangle(cornerRadius:20)
                        .foregroundStyle(Color.gray)
                        .opacity(0.5)
                )
                .overlay(
                    Text(activity)
                        .foregroundStyle(Color.white)
                )
        }
    }
}




#Preview {
    largeActivityCard(activity: "Football Game Sunday!",imageName:"sanford")
    smallActivityCard(activity: "Football Game Sunday!",imageName:"sanford")
}
