//
//  SettingsView.swift
//  ChatPrototype
//
//  Created by Catalin Posedaru on 3/11/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                .padding()
                .background(
                    Color.black,
                    in: RoundedRectangle(cornerRadius: 8)
                )
                .foregroundStyle(Color.white)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(30)
    }
}

#Preview {
    SettingsView()
}
