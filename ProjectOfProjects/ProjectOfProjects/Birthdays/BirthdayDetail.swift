//
//  BirthdayDetail.swift
//  ProjectOfProjects
//
//  Created by Catalin Posedaru on 27/11/25.
//

import SwiftUI
import SwiftData

struct BirthdayDetail: View {
    @Bindable var friend: Friend

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Text("New birthday")
                .font(.headline)

            Form {
                DatePicker(
                    "Date",
                    selection: $friend.birthday,
                    in: Date.distantPast...Date.now,
                    displayedComponents: .date
                )
                TextField("Name", text: $friend.name)
                    .textFieldStyle(.roundedBorder)
                TextField("Note", text: $friend.notes)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    dismiss()
                }
            }
            ToolbarItem (placement: .cancellationAction){
                Button("Cancel") {
                    context.delete(friend)
                    dismiss()
                }
            }
        }
        .padding()
        .background(.bar)
    }
}
