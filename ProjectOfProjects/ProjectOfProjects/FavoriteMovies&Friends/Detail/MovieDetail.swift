import SwiftUI
import SwiftData

struct MovieDetail: View {
    @Bindable var movie: Movie
    //@Bindable var castList: [Cast]
    let isNew: Bool
    @Query private var castList: [Cast]
    @State private var showCastList: Bool = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context


    init(movie: Movie, isNew: Bool = false) {
        self.movie = movie
        self.isNew = isNew
    }

    var sortedFriends: [MovieFriend] {
        movie.favoritedBy.sorted { first, second in
            first.name < second.name
        }
    }

    public func deleteLike(indexes: IndexSet) {
        for index in indexes {
            movie.favoritedBy[index].favoriteMovie = nil
        }
    }


    var body: some View {
        Form {
            TextField("Title", text: $movie.title)

            DatePicker(
                "Release date",
                selection: $movie.releaseDate,
                displayedComponents: .date
            )

            if !movie.favoritedBy.isEmpty {
                Section("Favorited by") {
                    ForEach(sortedFriends) { friend in
                        Text(friend.name)
                    }
                    .onDelete(perform: deleteLike(indexes:))

                }
            }
            Section("Cast members") {

                    Button("Add cast members to this movie") {
                        showCastList = true
                    }
                    .buttonStyle(.borderless)
                List {
                    ForEach(movie.movieCast) { cast in
                        NavigationLink(cast.name)  {
                            CastDetail(cast: cast)
                        }
                    }
                }

            }
            Section ("See every cast available") {
                List {
                    CastList(movie: movie)
                }
            }
        }
        .sheet (isPresented: $showCastList, onDismiss: {
            showCastList = false
        }) {
            List {
                ForEach(castList) { cast in
                    Button(cast.name) {
                        movie.movieCast.append(cast)
                        showCastList = false
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle(isNew ? "New Movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
            .modelContainer(for: [Movie.self, Cast.self])
    }
}
