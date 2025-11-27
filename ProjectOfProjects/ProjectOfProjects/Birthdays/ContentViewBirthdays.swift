//
//  ContentView.swift
//  Birthdays
//
//  Created by Catalin Posedaru on 20/11/25.
//

import SwiftUI
import SwiftData

struct ContentViewBirthdays: View {
    @Query(sort:\Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context //Provee el contexto entre

    @State private var newName = ""
    @State private var newDate = Date.now
    @State private var notes = ""
    @State private var newFriend: Friend?

    private func addFriend() {
        let newFriend = Friend(name:"", birthday: .now, notes: "")
        context.insert(newFriend)
        self.newFriend = newFriend
    }

    var body: some View {
        VStack {
            NavigationStack {
                List(friends) { friend in
                    HStack {
                        if friend.isBirthdayToday {
                            Image(systemName: "birthday.cake")
                                .foregroundColor(.yellow)
                        }
                        Text(friend.name)
                            .bold(friend.isBirthdayToday)
                        Divider()
                            .padding()
                        Text(friend.notes)
                            .bold(friend.isBirthdayToday)
                        Divider()
                            .padding()
                        Spacer()
                        Text(
                            friend.birthday,
                            format: .dateTime.month(.abbreviated).day().year()
                        )
                        Button("Delete", systemImage: "minus.circle.fill") {
                            context.delete(friend)
                        }
                        .labelStyle(.iconOnly)
                        .foregroundColor(.red)
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button("Add friend", action: addFriend)
                    }
                }
                .sheet(item: $newFriend) { friend in
                    NavigationStack {
                        BirthdayDetail(
                            friend: friend
                        )
                        .interactiveDismissDisabled(true)
                    }
                }

            }
            .navigationTitle("Birthdays")
        }
    }
}

#Preview {
    ContentViewBirthdays()
        .modelContainer(for: Friend.self, inMemory: true) //modelContext ya no funciona!
}
