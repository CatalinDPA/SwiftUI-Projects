//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Catalin Posedaru on 6/11/25.
//

import SwiftUI
import SwiftData

struct ContentViewPickAPal: View {
    @Environment(\.modelContext) private var context
    @Query private var pals: [Pal]

    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedname = false
    @State private var savedPals: [Pal] = []
    @State private var warning: String = ""
    
    var body: some View {
        VStack {
            VStack (spacing: 8) {
                TitleView(
                    systemName: "person.3.sequence.fill",
                    title: "Pick-a-Pal",
                    titleColor: Color.accentColor,
                    backColor: Color.accentColor
                )
            }
            .symbolRenderingMode(.hierarchical)
            .font(.title)
            .bold()
            
            
            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            
            List {
                ForEach(pals) { pal in
                    Text(pal.name)
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
                    if !nameToAdd.isEmpty && !pals.contains(Pal(name: nameToAdd)){
                        nameToAdd = nameToAdd
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                        context.insert(Pal(name: nameToAdd))
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
                if let randomPal = pals.randomElement() {
                    pickedName = randomPal.name
                    if shouldRemovePickedname {
                        context.delete(randomPal)
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
                    if !pals.isEmpty {
                        for pal in pals {
                            savedPals.append(pal)
                        }
                        for pal in pals {
                            context.delete(pal)
                        }
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
                    if savedPals.isEmpty {
                        warning = "Nothing to load"
                    } else {
                        warning = ""
                        for pal in savedPals {
                            context.insert(pal)
                        }
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
        .modelContainer(for: Pal.self)
}
