//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 25/11/25.
//

import SwiftUI
import SwiftData

struct ContentViewMovieFriends: View {
    var body: some View {
        VStack {
            TabView {
                Tab("Friends", systemImage: "person.and.person") {
                    FriendList()
                }

                Tab("Movies", systemImage: "film.stack") {
                    MovieList()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentViewMovieFriends()
        .modelContainer(SampleData.shared.modelContainer)
}
