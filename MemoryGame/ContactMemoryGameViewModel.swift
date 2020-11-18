//
//  ContactMemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 16.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import Foundation

class ContactMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<String>
    @Published private var points: Int
    
    init() {
        model = ContactMemoryGameViewModel.createMemoryGame()
        points = 0
    }
    
    
    private static func createMemoryGame()->MemoryGameModel<String>{
        
        let possibleEmojis: Array<String> = ["🦄","🐧", "🐻", "🐳","🐌","🐡","🐙","🐝","🐼","🐭","🐷","🐮","🐔"]
        var emojis: Array<String> = []
        
        for index in 0..<3{
            emojis.append(possibleEmojis[index])
        }
        
        return  MemoryGameModel<String>(numberOfPairsOfCards: emojis.count, cardContentFactory: { pairIndex in
            return emojis[pairIndex]
        })
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGameModel<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGameModel<String>.Card){
        model.choose(card: card)
        gameFinished()
    }
    
    func resetGame(){
        model = ContactMemoryGameViewModel.createMemoryGame()
    }
    
    func gameFinished(){
        var matched = 0
        let cardcount = model.cards.count
        for index in 0..<cardcount{
            if (model.cards[index].isMatched) {
                print(index, " matched")
                matched += 1
            }
        }
        
        if( matched == cardcount){
            print("all matched, game finished")
            self.points = model.getPoints()
            
        }
        
    }
            
    func getPoints()->Int{
        return model.getPoints()
    }
    
    
}
