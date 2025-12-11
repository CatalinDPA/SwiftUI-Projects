//
//  DifficultSettingsView.swift
//  Alphabetizer
//
//  Created by Catalin Posedaru on 10/12/25.
//

import SwiftUI

struct SettingsViewAlphabetizer: View {
    @Environment(Alphabetizer.self) private var alphabetizer
    @State private var difficulty = false
    //Ipad
    /*var body: some View {
        Text("Select a difficulty")
            .font(.title)
        Picker("Select difficulty", selection: $difficulty) {
            Text("Easy")
                .tag(false)
            Text("Hard")
                .tag(true)
        }
        .pickerStyle(.segmented)
        .scaleEffect(1.5)
        .padding(.horizontal, 200)
        .onChange(of: difficulty) { _, newValue in
            alphabetizer.difficulty = newValue
        }
        .padding()
     }*/
    //Iphone
    var body: some View {
        Text("Select a difficulty")
            .font(.system(size: 18))
        Picker("Select difficulty", selection: $difficulty) {
            Text("Easy")
                .tag(false)
            Text("Hard")
                .tag(true)
        }
        .pickerStyle(.segmented)
        .onChange(of: difficulty) { _, newValue in
            alphabetizer.difficulty = newValue
        }
        .padding()
    }
}

#Preview {
    SettingsViewAlphabetizer()
        .environment(Alphabetizer())
}
