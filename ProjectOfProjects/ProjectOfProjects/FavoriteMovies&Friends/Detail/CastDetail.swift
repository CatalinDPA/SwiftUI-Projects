//
//  CastDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Catalin Posedaru on 4/12/25.
//

import SwiftUI
import SwiftData
import SwiftUI

struct CastDetail: View {
    @Bindable var cast: Cast
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss


    var body: some View {
        NavigationStack {
            HStack {
                Text("Cast name")
                    .fontWeight(.semibold)
                TextField("Cast name", text: $cast.name)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            List {
                ForEach(cast.movies) { cast in
                    Text(cast.title)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    context.insert(cast)
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .padding(32)

    }
}

#Preview {
    CastDetail(cast: Cast(name: ""))
        .modelContainer(SampleData.shared.modelContainer)
}
