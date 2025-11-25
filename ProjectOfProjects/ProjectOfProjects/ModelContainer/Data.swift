import Foundation
import SwiftData

@MainActor
class Data {
    static let shared = Data()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    private init() {
        let schema = Schema([
            Friend.self,
            Pal.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )

            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}

