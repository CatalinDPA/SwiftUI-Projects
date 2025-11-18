//
//  ContentView.swift
//  DiceProject
//
//  Created by Catalin Posedaru on 5/11/25.
//

import SwiftUI

struct ContentViewDice: View {
    @State private var numberOfDice: Int = 1
    @State private var typeOfGame = false
    @State private var diceCount: Int = 6;
    
    var body: some View {
        VStack {
            DiceTitleView()
            
            DiceGame(
                typeOfGame: $typeOfGame,
                numberOfDice: $numberOfDice,
                diceCount: $diceCount
            )
            
            FooterView(
                typeOfGame: $typeOfGame,
                numberOfDice: $numberOfDice,
                diceCount: $diceCount
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appBackground)
        .tint(.white)
    }
}

struct DiceTitleView: View {
    var body: some View {
        VStack {
            Text("Dice Roller!")
                .font(.largeTitle.lowercaseSmallCaps())
                .foregroundStyle(.white)
                .shadow(radius: 12)
                .bold()
        }
    }
}

struct DiceGame: View {
    @Binding var typeOfGame: Bool
    @Binding var numberOfDice: Int
    @Binding var diceCount: Int
    var body: some View {
        ScrollView (.vertical){
            if !typeOfGame {
                let rows = numberOfDice / 4 + (numberOfDice % 4 == 0 ? 0 : 1)
                ForEach(
                    0..<rows,
                    id: \.description) { row in
                        HStack {
                            ForEach (0..<4, id: \.description) { column in
                                let index = row * 4 + column
                                if index < numberOfDice {
                                    DiceView(diceCount: $diceCount)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        }
            } else {
                DiceView(diceCount: $diceCount)
            }
        }
        .scrollDisabled(numberOfDice <= 24)
    }
}

struct FooterView: View {
    @Binding var typeOfGame: Bool
    @Binding var numberOfDice: Int
    @Binding var diceCount: Int
    var body: some View {
        VStack {
            Toggle(typeOfGame ? "One big dice" : "More different dices", isOn: $typeOfGame)
                .foregroundColor(.white)
                .font(.title3)
                .onChange(of: typeOfGame) {
                    diceCount = 6
                    numberOfDice = 1
                }
            HStack {
                Button("Remove Dice", systemImage: "minus.circle.fill") {
                    if !typeOfGame {
                        withAnimation(.easeOut(duration: 1)) {
                            numberOfDice -= 1
                        }
                    } else {
                        diceCount -= 6
                    }
                }
                .disabled(!typeOfGame ? numberOfDice == 1 : diceCount == 6)
                Text(typeOfGame ? "\(diceCount)" : "")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Button("Add Dice", systemImage: "plus.circle.fill") {
                    if !typeOfGame {
                        withAnimation(.easeInOut(duration: 1)
                        ) {
                            numberOfDice += 1
                        }
                    } else {
                        diceCount += 6
                    }
                }
                .disabled(!typeOfGame ? numberOfDice == 60 : diceCount == 24)
            }
            .padding()
            .labelStyle(.iconOnly)
            
            .font(.title)
        }
        .toggleStyle(.switch)
    }
}


#Preview {
    ContentViewDice()
}
