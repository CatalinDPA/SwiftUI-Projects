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
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New birthday")
                        .font(.headline)
                    DatePicker(
                        selection: $newDate,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    ) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Note", text: $notes)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate, notes: notes)
                        context.insert(newFriend)
                        newName = ""
                        newDate = Date.now
                    }
                    .disabled(newName.isEmpty)
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    }
}

#Preview {
    ContentViewBirthdays()
        .modelContainer(for: Friend.self, inMemory: true) //modelContext ya no funciona!
}
