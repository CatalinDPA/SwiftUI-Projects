import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \MovieFriend.name) private var friends: [MovieFriend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: MovieFriend?

    init(nameFilter: String = "") {
        let predicate = #Predicate<MovieFriend> { friend in
            nameFilter.isEmpty || friend.name
                .localizedStandardContains(nameFilter)
        }

        _friends = Query(filter: predicate, sort: \MovieFriend.name)
    }

    private func addFriend() {
        let newFriend = MovieFriend(name:"")
        context.insert(newFriend)
        self.newFriend = newFriend
    }

    private func deleteFriend(indexes: IndexSet) {
        for index in indexes {
            context.delete(friends[index])
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink(friend.name) {
                                FriendDetail(friend: friend)
                            }
                        }
                        .onDelete(perform: deleteFriend(indexes:))
                    }
                    
                } else {
                    ContentUnavailableView("Add Friends", systemImage: "person.and.person")
                }
            }
            .navigationTitle("Friends")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem {
                    Button("Add friend", systemImage: "plus", action: addFriend)
                }
                ToolbarItem (placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack {
                    FriendDetail(friend: friend, isNew: true)
                        .interactiveDismissDisabled()
                }
            }
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
    FriendList()
        .modelContainer(for: MovieFriend.self, inMemory: true)
}
