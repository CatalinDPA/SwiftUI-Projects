import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    var friend: MovieFriend {
        MovieFriend.sampleData.first!
    }

    var movie: Movie {
        Movie.sampleData.first!
    }

    private init() {
        let schema = Schema([
            MovieFriend.self,
            Movie.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            insertSampleData()

            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func insertSampleData() {
        for friend in MovieFriend.sampleData {
            context.insert(friend)
        }

        for movie in Movie.sampleData {
            context.insert(movie)
        }

        MovieFriend.sampleData[0].favoriteMovie = Movie.sampleData[1]
        MovieFriend.sampleData[2].favoriteMovie = Movie.sampleData[0]
        MovieFriend.sampleData[3].favoriteMovie = Movie.sampleData[4]
        MovieFriend.sampleData[4].favoriteMovie = Movie.sampleData[0]

    }
}
