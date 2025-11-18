//
//  DiceView.swift
//  DiceProject
//
//  Created by Catalin Posedaru on 5/11/25.
//

import SwiftUI

struct DiceView: View {
    @Binding public var diceCount: Int
    @State private var numberOfPips: Int = 1
    @State private var diceList: [AnyView] = []

    
    func createDice(numberOfPips: Int, previousDices: AnyView?){
        if let oldDice = previousDices {
            diceList.append(oldDice)
        }
        if numberOfPips > 6 {
            let newDice = AnyView(Image(systemName: "die.face.6.fill")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.black, .white))
            createDice(numberOfPips: numberOfPips - 6, previousDices: newDice)
        } else {
            let newDice = AnyView(Image(systemName: "die.face.\(numberOfPips).fill")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.black, .white))
            diceList.append(newDice)
        }
    }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    numberOfPips = Int.random(in: 1...diceCount)
                    diceList = []
                    createDice(
                        numberOfPips: numberOfPips,
                        previousDices: nil
                    )
                }
            }, label: {
                    VStack {
                        ForEach ( diceList.indices, id: \.self) { index in
                            diceList[index]
                        }
                    }
                    .onAppear {
                        createDice(
                            numberOfPips: numberOfPips,
                            previousDices: nil
                        )
                    }
                })
            Spacer()
                }
                
            
        }
    }
