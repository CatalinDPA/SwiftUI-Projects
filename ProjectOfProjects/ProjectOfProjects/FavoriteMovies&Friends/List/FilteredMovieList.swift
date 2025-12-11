//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 1/12/25.
//

import SwiftUI
import SwiftData

struct FilteredMovieList: View {
    @State private var searchText = ""

    var body: some View {

        NavigationStack {
            MovieList(titleFilter: searchText)
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer)

        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
