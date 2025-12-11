//
//  CastList.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 4/12/25.
//

import SwiftUI
import SwiftData


struct CastList: View {
    @Environment(\.modelContext) private var context
    @Query private var castList: [Cast]
    @State private var newCast: Cast?
    @Bindable var movie: Movie
    @State private var showSheet = false

    func deleteCast(indexes:IndexSet) {

        for index in indexes {
            context.delete(castList[index])
            movie.movieCast.removeAll { cast in
                cast.name == castList[index].name
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Button("Create cast members") {
                    newCast = Cast(name: "")
                }
                .buttonStyle(.borderless)
                .padding()
                List{
                    ForEach(castList) { cast in
                        Section {
                            Text(cast.name)
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteCast(indexes:))
                }
            }
        }
        .sheet(item: $newCast) { cast in
            NavigationStack {
                CastDetail(cast: cast)
            }
        }
    }
}

