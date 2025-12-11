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
                    FilteredFriendList()
                }

                Tab("Movies", systemImage: "film.stack") {
                    FilteredMovieList()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentViewMovieFriends()
        .modelContainer(for: [Movie.self, MovieFriend.self])
}
