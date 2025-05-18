//
//  ContentView.swift
//  CampusCart
//
//  Created by wayne on 5/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        VStack(spacing: 20){
                
                TopBar(title: "CAMP")
            
            HStack(spacing:10) {
                smallActivityCard(activity: "90 degrees", imageName: "sky")
                smallActivityCard(activity: "Saturday in athens", imageName: "sanford")
            }.padding()
            largeActivityCard(activity: "Red & Black UGA",imageName: "rednblack")
            Divider()
            
           
                Spacer()
                Divider()
                BottomBar()
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


func homePage() {
    print("button clicked")
}

struct BottomBar: View {
    
    var body: some View {
        HStack {
            BottomBarButton(systemImage: "gear", action: homePage)
            BottomBarButton(systemImage: "bag.fill", action: homePage)
            BottomBarButton(systemImage: "house", action: homePage)
            BottomBarButton(systemImage: "message.fill", action: homePage)
            BottomBarButton(systemImage: "person.crop.circle.fill", action: homePage)
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
                .padding(10)
        }
    }
}



#Preview {
    ContentView()
}


