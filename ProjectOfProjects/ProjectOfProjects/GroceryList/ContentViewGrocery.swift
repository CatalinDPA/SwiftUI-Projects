//
//  ContentView.swift
//  GroceryList
//
//  Created by Catalin Posedaru on 24/11/25.
//

import SwiftUI
import SwiftData

struct ContentViewGrocery: View {
    @Query private var groceries: [Grocery]
    @Environment(\.modelContext) private var context

    @State private var groceryName: String = ""

    func addGrocery() {
        if (!groceryName.isEmpty) {
            context.insert(Grocery(name: groceryName))
            groceryName = ""
            do {
                if (context.hasChanges) {
                    try context.save()
                }
            } catch {
                fatalError("Error trying to save Context")
            }
        }
    }

    var body: some View {
        VStack {
            TitleView(
                systemName: "pencil.and.list.clipboard.rtl",
                title: "Grocery List",
                titleColor: Color.white,
                backColor: .white
            )
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()
            List {
                ForEach(groceries) { grocery in
                    HStack {
                        HStack {
                            Text(grocery.name)
                                .font(.title3)
                                .padding(.trailing, 12)
                            Image(systemName: grocery.isBought ? "checkmark" : "stroke.line.diagonal.slash")
                                .font(.title)
                                .foregroundColor(grocery.isBought ? .green : .red)
                                .padding(8)
                                .clipShape(.circle)
                        }
                        
                        .onTapGesture {
                            grocery.isBought = !grocery.isBought
                        }
                        Spacer()
                        Button("", systemImage: "minus.circle.fill") {
                            context.delete(grocery)
                        }
                        .buttonStyle(.glass)
                        .font(.title)
                        .tint(.brown)
                        .labelStyle(.iconOnly)
                    }
                }

            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack (alignment: .center) {
                TextField("Grocery name", text: $groceryName)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 6)
                    .onSubmit {
                        addGrocery()
                    }
                Button("Add Grocery") {
                    addGrocery()
                }
                .buttonStyle(.glassProminent)
                .tint(.green)
                Button("Reset groceries status") {
                    for gro in groceries {
                        gro.isBought = false
                    }
                }
            }
        }

        .padding()
    }
}
