import SwiftUI
import SwiftData

struct FilteredMovieList: View {
    @State private var searchText = ""
    @Binding var newMovie: Movie?
    var body: some View {
        NavigationStack {
            MovieList(
                newMovie: $newMovie,
                titleFilter: searchText
            )
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer)
        }
        
    }
}
