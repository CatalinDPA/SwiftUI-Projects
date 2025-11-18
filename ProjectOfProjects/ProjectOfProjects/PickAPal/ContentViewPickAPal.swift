//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Catalin Posedaru on 6/11/25.
//

import SwiftUI

struct ContentViewPickAPal: View {
    @State private var names: [String] = [ ]
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedname = false
    @State private var nameSaves: [String] = []
    @State private var warning: String = ""
    
    var body: some View {
        VStack {
            VStack (spacing: 8) {
                TitleView(systemName: "person.3.sequence.fill", title: "Pick-a-Pal")
            }
            .foregroundStyle(.tint)
            .symbolRenderingMode(.hierarchical)
            .font(.title)
            .bold()
            
            
            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            
            List {
                ForEach(names, id: \.description) { name in
                    Text(name)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Divider()
            TextField("Add name", text: $nameToAdd)
                .onTapGesture {
                    nameToAdd = ""
                }
                .autocorrectionDisabled()
                .onSubmit {
                    warning = ""
                    if !nameToAdd.isEmpty && !names.contains(nameToAdd){
                        nameToAdd = nameToAdd
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        names.append(nameToAdd)
                        nameToAdd = ""
                    } else {
                        if nameToAdd.isEmpty {
                            warning = "The name is empty"
                        } else {
                            warning = "This name is already in: \(nameToAdd)"
                        }
                    }
                }
                
            
            Toggle("Remove when picked", isOn: $shouldRemovePickedname)
            Button {
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    if shouldRemovePickedname {
                        names.removeAll { name in
                        (name == randomName)
                        }
                    }
                } else {
                    warning = "No name to pick"
                    pickedName = ""
                }
            } label: {
                Text("Pick a random name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
            HStack {
                Button {
                    if !names.isEmpty {
                        nameSaves = names
                        names = []
                        warning = ""
                    } else {
                        warning = "Nothing to save"
                    }
                } label: {
                        Text("Save name list")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                    }
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                Button {
                    if nameSaves.isEmpty {
                        warning = "Nothing to load"
                    } else {
                        warning = ""
                        names = nameSaves
                    }
                } label: {
                        Text("Load list")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                    }
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                
                }
            Text(warning)
            }
            
        .padding()
        }
        
    }


#Preview {
    ContentViewPickAPal()
}
