//
//  ContentView.swift
//  AddressLabel
//
//  Created by Catalin Posedaru on 10/11/25.
//

import SwiftUI

struct ContentViewAddressLabel: View {
    @State private var name = ""
    @State private var city = ""
    @State private var country = ""
    @State private var showAddress = false
    
    
    var body: some View {
        VStack {
            Image(systemName: "location.magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.tint)
            Text("Address finder!")
                .font(.title)
                .bold()
        }
        .padding(.top, 28)
        .padding()
        VStack (spacing: 12){
            HStack {
                Text("Name")
                    .padding()
                TextField("Add your name", text: $name)
                    .disableAutocorrection(false)
            }
            HStack {
                Text("Country")
                    .padding()
                TextField("Add your country", text: $country)
            }
            HStack{
                Text("City")
                    .padding()
                TextField("Add your city", text: $city)
            }
        }
        .padding()
        
        Button {
            if !name.isEmpty && !city.isEmpty && !country.isEmpty {
                withAnimation(.easeIn(duration: 1)) {
                    showAddress.toggle()
                }
            }
            
        } label: {
            Text("Format address")
                .foregroundStyle(.black)
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.borderedProminent)
        .tint(.btn)
        
        if showAddress {
            Text("Hello \(name), you are from \(country), \(city) right?")
                .font(.title3)
        }
        Spacer()

    }
}

#Preview {
    MainContentView()
}
