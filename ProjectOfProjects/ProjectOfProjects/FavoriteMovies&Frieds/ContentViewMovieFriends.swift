//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 25/11/25.
//

import SwiftUI
import SwiftData


struct ContentViewMovieFriends: View {
    @State private var actualTab: Int = 1
    @State private var newFriend: MovieFriend?
    @State private var newMovie: Movie?
    @Environment(\.modelContext) var context

    private func add() {
        if actualTab == 1 {
            newFriend = MovieFriend(name: "")
        } else if actualTab == 2 {
            newMovie = Movie(title: "", releaseDate: .now)
        }
    }

    var body: some View {
            TabView (selection: $actualTab) {
                FriendList(newFriend: $newFriend)
                    .tabItem { Label("Friends", systemImage: "person.and.person") }
                    .tag(1)

                FilteredMovieList(newMovie: $newMovie)
                    .tabItem { Label("Movies", systemImage: "film.stack") }
                    .tag(2)

            }
            .navigationTitle(actualTab == 1 ? "Friends" : "Movies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(
                        "Add",
                        systemImage: "plus",
                        action: add
                    )
                }
                ToolbarItem (placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .padding()
    }
}

#Preview {
    ContentViewMovieFriends()
        .modelContainer(for: [Movie.self, MovieFriend.self])
}
