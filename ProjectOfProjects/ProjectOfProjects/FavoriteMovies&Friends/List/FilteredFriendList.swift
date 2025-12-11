//
//  FilteredFriendList.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 3/12/25.
//

import SwiftUI
import SwiftData

struct FilteredFriendList: View {
    @State private var searchName = ""

    var body: some View {
        NavigationStack {
            FriendList(nameFilter: searchName)
                .searchable(text: $searchName,
                            placement: .navigationBarDrawer)
        }
    }
}

#Preview {
    FilteredFriendList()
        .modelContainer(SampleData.shared.modelContainer)
}
