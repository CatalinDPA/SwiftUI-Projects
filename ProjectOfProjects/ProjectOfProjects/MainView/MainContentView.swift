//
//  ContentView.swift
//  ProjectOfProjects
//
//  Created by Catalin Posedaru on 13/11/25.
//

import SwiftUI
import SwiftData

struct MainContentView: View {
    var body: some View {
        NavigationStack {
            ZStack (alignment: .top) {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.white, lineWidth: 4)
                    .padding(6)
                    .ignoresSafeArea()
                    .zIndex(10)
                MainVStack()
            }
        }
    }

}

#Preview {
    MainContentView()
}



struct Footer: View {
    private let caseList = Projects.allCases
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .ignoresSafeArea()
                .frame(maxHeight: 100)
                .foregroundColor(Color.deepNavy)
            VStack {
                Text("Repositorio de proyectos de Catalin,\ncon SwiftUI")
                    .font(.title3)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                Image(systemName: "person.fill")
                    .foregroundColor(.accent)
                    .font(.title)
                    .padding(.top, 4)
            }
        }
    }
}

struct MainVStack: View {
    private let caseList = Projects.allCases
    var body: some View {
        VStack {
            TitleView(
                systemName: "list.bullet.rectangle.fill",
                title: "Project List",
                titleColor: .white,
                backColor: .white,
            )
            .zIndex(1)
            .padding(8)
            .font(.system(size: 48))
            .frame(maxWidth: .infinity, maxHeight: 120)
            .background(Color.deepNavy)
            .frame(minHeight: 90)


            ScrollView (.vertical) {
                ItemListView()
            }
            .scrollDisabled(Projects.allCases.count < 10)
            .padding(12)
            .background(.white)
            .font(.system(size: 22))
            .cornerRadius(8)
            .ignoresSafeArea(.all)

            Footer()
        }
    }
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
                    .foregroundColor(.softGray)
                    .bold()
                    .shadow(radius: 4)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
                .padding(.horizontal, 24)
                .padding(.vertical, 4)
        }
    }
}

