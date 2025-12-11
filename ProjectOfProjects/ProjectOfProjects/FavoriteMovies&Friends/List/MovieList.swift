import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    @State private var sortByDate: Bool = false

    init(titleFilter: String = "") {
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title
                .localizedStandardContains(titleFilter)
        }

        _movies = Query(filter:predicate, sort: \Movie.title)
    }

    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }

    private var sortedMovies: [Movie] {
        return movies.sorted { first, second in
            first.releaseDate > second.releaseDate
        }
    }

    public func deleteMovie(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if !movies.isEmpty {
                    List {
                        ForEach(sortByDate ? sortedMovies : movies) { movie in
                            NavigationLink(movie.title) {
                                MovieDetail(movie: movie)
                            }
                        }
                        .onDelete(perform:  deleteMovie(indexes:))
                    }

                } else {
                    ContentUnavailableView("Add Movies", systemImage: "film.stack")
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem {
                    Button("Add movie", systemImage: "plus", action: addMovie)
                }
                ToolbarItem (placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem (placement: .navigation) {
                    Toggle(
                        (sortByDate ? "Sorting by date" : "Sorting by name"),
                        isOn: $sortByDate
                    )
                }
            }
            .sheet(item: $newMovie) { movie in
                NavigationStack {
                    MovieDetail(movie: movie, isNew: true)
                        .interactiveDismissDisabled()
                }
            }

        }
    }
}


#Preview {
    NavigationStack {
        MovieList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty") {
    NavigationStack {
        MovieList()
            .modelContainer(for: Movie.self, inMemory: true)
    }
}
