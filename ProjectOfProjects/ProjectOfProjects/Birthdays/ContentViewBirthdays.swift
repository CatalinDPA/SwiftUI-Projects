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
    @Query private var gifts: [Gift]
    @Environment(\.modelContext) private var context //Provee el contexto entre
    
    @State private var newName = ""
    @State private var newDate = Date.now
    @State private var notes = ""

    @State private var newGift: Gift?

    @State private var actualFriend: Friend?

    func createGift() {
        let newGift = Gift(name: "")
        context.insert(newGift)
        self.newGift = newGift
    }

    func deleteGift(gift: Gift) {
        context.delete(gift)

        do {
            try context.save()
        } catch {
            fatalError("Error al borrar regalo")
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    Section {
                    VStack (alignment: .center) {
                        VStack {
                            if friend.isBirthdayToday {
                                Image(systemName: "birthday.cake")
                                    .foregroundColor(.yellow)
                            }
                            Text(friend.name)
                                .bold(friend.isBirthdayToday)
                            Divider()
                        }
                        HStack {
                            Text(friend.notes.isEmpty ? "No notes" : friend.notes)
                                .bold(friend.isBirthdayToday)
                                .padding(.horizontal, 8)
                            Divider()
                            Button(
                                (friend.gift?.name) ?? "Select gift") {
                                    actualFriend = friend
                                }
                                .padding(.horizontal, 8)
                                .buttonStyle(.borderless)
                            Divider()
                            Text(
                                friend.birthday,
                                format: .dateTime.month(.abbreviated).day().year()
                            )
                            .padding(.horizontal, 8)
                            Divider()
                            Button("Delete", systemImage: "minus.circle.fill") {
                                context.delete(friend)
                            }
                            .padding(.horizontal, 8)
                            .labelStyle(.iconOnly)
                            .buttonStyle(.borderless)
                            .foregroundColor(.red)
                        }
                        }

                    }
                    .frame(maxWidth: .infinity)
                }

            }
            .background(.white)
            .scrollDisabled(friends.count <= 3)
            .toolbar {
                ToolbarItem {
                    Button("Crear regalo", systemImage: "plus", action: createGift)
                        .labelStyle(.titleOnly)
                }
            }
            .sheet (item: $actualFriend,
                    onDismiss: {
                actualFriend = nil}) { friend in
                GiftList(friend: friend)
            }
            .sheet(
                item: $newGift
            ) { gift in
                NavigationStack {
                    GiftDetail(gift: gift)
                        .interactiveDismissDisabled(true)
                }
            }
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
        .navigationTitle("Birthdays")
    }
}

#Preview {
    ContentViewBirthdays()
        .modelContainer(for: [Friend.self, Gift.self])
}
