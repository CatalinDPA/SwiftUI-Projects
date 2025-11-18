//
//  ContentView.swift
//  OrganizeYourViews
//
//  Created by Catalin Posedaru on 5/11/25.
//

import SwiftUI

struct ContentViewOrganize: View {
    @State private var mood  = ""
    var body: some View {
        TabView {
            MoodViewFull(value: $mood)
                .tabItem {
                    Label("Moods", systemImage: "face.dashed.fill")
                        .labelStyle(.iconOnly)
                }
            VStack {
                HalfCard()
                HalfCard()
                    .rotationEffect(.degrees(180))
            }
            .foregroundColor(.red)
            .background (
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black)
            )
            .padding()
            .aspectRatio(0.7, contentMode: .fit)
            .tabItem {
                Label("card", systemImage: "suit.heart")
                    .labelStyle(.iconOnly)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
