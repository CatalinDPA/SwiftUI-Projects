//
//  ContentView.swift
//  ChatPrototype
//
//  Created by Catalin Posedaru on 3/11/25.
//

import SwiftUI

struct ContentViewChatPrototype: View {
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Label("Journal", systemImage: "book")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ChatView: View {
    var body: some View {
        VStack (spacing: 25) {
            HStack {
                Text("Perseverance")
                    .padding()
                    .background(Color.yellow, in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 4)
                Text("Hard work")
                    .padding()
                    .background(Color.red, in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 20)
            }
            //Hacer que la última sea de igual tamaño
            VStack (alignment: .center, spacing: 12) {
                Text("Strong will")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 16)
                Text("Team Worker")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 1)
                Text("Big Goals")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.purple ,in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 12)
                Text("Star")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.mint, in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 8)
            }
            .fixedSize()
            
            Spacer()
            LearningViews()
        }
        .padding()
    }
}

#Preview {
    ContentViewChatPrototype()
}

