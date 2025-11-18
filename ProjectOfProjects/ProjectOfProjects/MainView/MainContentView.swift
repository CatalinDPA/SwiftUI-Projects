//
//  ContentView.swift
//  ProjectOfProjects
//
//  Created by Catalin Posedaru on 13/11/25.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationStack {
            TitleView(
                systemName: "list.bullet.rectangle.fill",
                title: "Project List"
            )
            .font(.system(size: 50))
            .frame(maxWidth: .infinity)
            .background(Color.deepNavy)
            .foregroundColor(.white)
            ScrollView (.vertical) {
                ItemListView()
            }
            .font(.system(size: 22))
            .background(Color.softGray)
            .cornerRadius(8)
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    MainContentView()
}



struct ItemListView: View {
    private let caseList = Projects.allCases
    var body: some View {
        ForEach(caseList, id: \.title) { project in
            NavigationLink (destination: project.navigationView) {
                Text(project.title)
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .background(Color.listItem)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 4)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            .padding(.top, 6)
        }
        .padding()
    }
}
