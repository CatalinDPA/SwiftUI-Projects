//
//  ProjectOfProjectsApp.swift
//  ProjectOfProjects
//
//  Created by Catalin Posedaru on 13/11/25.
//

import SwiftUI
import SwiftData

@main
struct ProjectOfProjectsApp: App {
    @State private var alphabetizer = Alphabetizer()

    var body: some Scene {
        WindowGroup {
            MainContentView()
                .modelContainer(
                    for: [
                        Friend.self,
                        Pal.self,
                        Grocery.self,
                        Movie.self,
                        MovieFriend.self,
                        Gift.self,
                        Cast.self,

                    ]
                )
                .environment(alphabetizer)
        }
    }
}
