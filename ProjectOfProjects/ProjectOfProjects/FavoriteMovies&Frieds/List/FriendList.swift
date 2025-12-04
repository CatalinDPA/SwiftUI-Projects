import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \MovieFriend.name) private var friends: [MovieFriend]
    @Binding var newFriend: MovieFriend?
    @Environment(\.modelContext) private var context

    func deleteFriend(indexes: IndexSet) {
        for index in indexes {
            context.delete(friends[index])
        }
    }
    func deleteFriend(friend: MovieFriend) {
        context.delete(friend)
    }

    var body: some View {
            Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends, id: \.name) { friend in
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
            .sheet(
                item: $newFriend,
                onDismiss: {
                    if let friend = newFriend {
                        deleteFriend(friend: friend )
                    }
                }
            ) { friend in
                NavigationStack {
                    FriendDetail(friend: friend, isNew: true)
                }
            }

    }
}

/*#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
    FriendList()
        .modelContainer(for: MovieFriend.self, inMemory: true)
}*/
