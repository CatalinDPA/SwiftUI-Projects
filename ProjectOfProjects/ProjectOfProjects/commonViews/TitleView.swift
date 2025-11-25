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
    var titleColor: Color?
    var backColor: Color?
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .foregroundColor(backColor != nil ? backColor : .black)

            Text(title)
                .font(.title)
                .bold()
                .padding(.bottom, 16)
                .foregroundColor(titleColor != nil ? titleColor : .black)
        }
    }
}

