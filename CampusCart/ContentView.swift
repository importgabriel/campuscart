//
//  ContentView.swift
//  CampusCart
//
//  Created by wayne on 5/18/25.
//


import SwiftUI

enum Tab {
    case home, market, messages, profile, settings
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "CAMP")

            // logic for
            switch selectedTab {
            case .home:
                homePage()
            case .market:
                marketPlacePage()
            case .messages:
                messagesPage()
            case .profile:
                profilePage()
            case .settings:
                settingsPage()
            }

            Spacer()

            BottomBar(selectedTab: $selectedTab)
        }
    }
}



struct TopBar: View {
    let title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
               
        }
        .frame(width:450)
        .background(Color.red)
        
        
        }
            }



struct BottomBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        Divider()
        HStack {
            BottomBarButton(systemImage: "gear", action: { selectedTab = .settings })
            BottomBarButton(systemImage: "bag.fill", action: { selectedTab = .market })
            BottomBarButton(systemImage: "house", action: { selectedTab = .home })
            BottomBarButton(systemImage: "message.fill", action: { selectedTab = .messages })
            BottomBarButton(systemImage: "person.crop.circle.fill", action: { selectedTab = .profile })
        }
    }
}


struct BottomBarButton: View {
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width:24,height:24)
                .padding(15)
        }
    }
}




