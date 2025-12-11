//
//  GiftDetail.swift
//  Birthdays
//
//  Created by Catalin Posedaru on 3/12/25.
//

import SwiftUI
import SwiftData

struct GiftDetail: View {
    @Bindable private var gift: Gift

    init(gift: Gift, ) {
        self.gift = gift
    }

    @Environment(\.modelContext) private var context;
    @Environment(\.dismiss) private var dismiss


    var body: some View {
        Form {
            TextField("Gift name", text: $gift.name)
        }
        .navigationTitle("New Gift")
        .toolbar {
            ToolbarItem (placement: .confirmationAction) {
                Button("Save") {
                    dismiss()
                }
            }
            ToolbarItem (placement: .cancellationAction) {
                Button("Cancel") {
                    context.delete(gift)
                    dismiss()
                }
            }
        }
    }
}
