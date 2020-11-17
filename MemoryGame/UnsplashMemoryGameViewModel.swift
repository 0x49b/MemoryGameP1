//
//  UnsplashMemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 16.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import Foundation

class UnsplashMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<String>
    
    init() {
        model = UnsplashMemoryGameViewModel.createMemoryGame()
    }
    
    private static func createMemoryGame()->MemoryGameModel<String>{
        let emojiis: Array<String> = ["😀"]
        
        return  MemoryGameModel<String>(numberOfPairsOfCards: emojiis.count, cardContentFactory: { pairIndex in
            return emojiis[pairIndex]
        })
    }
    
}
