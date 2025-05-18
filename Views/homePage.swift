//
//  homePage.swift
//  CampusCart
//
//  Created by wayne on 5/18/25.
//
import SwiftUI

struct homePage: View {
    var body: some View {
        VStack(spacing: 20){
            HStack(spacing:10) {
                smallActivityCard(activity: "90 degrees", imageName: "sky")
                smallActivityCard(activity: "Saturday in athens", imageName: "sanford")
            }
            .padding()
            
            largeActivityCard(activity: "Red & Black UGA",imageName: "rednblack")

            Divider()
            Text("Recent Listings")
                .font(.title2)
        }
    }
}
