import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @Binding private var newMovie: Movie?

    init(newMovie: Binding<Movie?>, titleFilter: String = "") {
        self._newMovie = newMovie
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title
                .localizedStandardContains(titleFilter)
        }

        _movies = Query(filter:predicate, sort: \Movie.title)
    }

    private func deleteMovie(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }

    var body: some View {
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies, id: \.title) { movie in
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
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
        }
    }
}
