//
//  GiftList.swift
//  Birthdays
//
//  Created by Catalin Posedaru on 4/12/25.
//

import Foundation
import SwiftData
import SwiftUI

struct GiftList: View {
    @Query var gifts: [Gift]
    @Bindable var friend: Friend

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    func deleteGift(indexes: IndexSet) {
        for index in indexes {
            context.delete(gifts[index])
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(gifts) { gift in
                    Text(gift.name)
                        .onTapGesture {
                            friend.gift = gift
                            dismiss()
                        }
                }
                .onDelete(perform: deleteGift(indexes:))
            }
        }
        .navigationTitle("Pick a gift")
        .navigationBarTitleDisplayMode(.large)
    }
}
