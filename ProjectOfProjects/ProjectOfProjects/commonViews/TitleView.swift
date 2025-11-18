//
//  TitleView.swift
//  ProjectOfProjects
//
//  Created by Catalin Posedaru on 18/11/25.
//

import SwiftUI

struct TitleView: View {
    var systemName: String
    var title: String
    var body: some View {
        VStack {
            Image(systemName: systemName)
                
            
            Text(title)
                .font(.title)
                .bold()
                .padding(.bottom, 16)
        }
    }
}

#Preview {
    TitleView(systemName: "list.bullet.rectangle.fill", title: "Project list")
}
