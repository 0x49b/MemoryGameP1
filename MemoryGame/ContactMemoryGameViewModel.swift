//
//  ContactMemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 16.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import SwiftUI
import Contacts

class ContactMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<UIImage>
    @Published private var points: Int
    @Published var loadingContacts: Bool = false
    var difficulty = 0
    var setPoints: ((Int) -> Void)
    @Published private var contactImg: [UIImage] = [UIImage]()
    let dispatchGroup = DispatchGroup()
    
    
    
    init(difficulty: Int, setPoints: @escaping ((Int) -> Void)) {
        model = MemoryGameModel<UIImage>(numberOfPairsOfCards: 0, cardContentFactory: { pairIndex in return UIImage() })
        points = 0
        self.difficulty = difficulty
        self.setPoints = setPoints
    }
    
    // developer.apple.com/documentation/contacts
    // https://medium.com/better-programming/build-a-swiftui-contacts-search-application-d41b414fe046
    public func createMemoryGame(difficulty: Int){
        
        loadingContacts = true
        self.contactImg.removeAll()
        print("difficulty set to ", difficulty)
        
        let contactStore = CNContactStore()
        let request = CNContactFetchRequest(keysToFetch: [CNContactImageDataKey as CNKeyDescriptor])

        do {
            try contactStore.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in

                DispatchQueue.global(qos: .userInitiated).async {
                    if let imageData = contact.imageData{
                        self.dispatchGroup.enter()
                        DispatchQueue.main.async {
                            self.contactImg.append(UIImage(data: imageData) ?? UIImage())
                            print("added photo \(imageData)")
                            self.dispatchGroup.leave()
                        }
                        print("contactImageCount1 \(self.contactImg.count)")
                    }
                }
            })

        } catch let error {
            print("Failed to enumerate contact \(error)")
        }

        print("contactImageCount \(self.contactImg.count)")

        dispatchGroup.notify(queue: .main) {
            var max = difficulty
            var pairIndexNumbers = [Int]()
            for i in 0..<difficulty{
                pairIndexNumbers.append(i)
            }
            if(difficulty>self.contactImg.count){
                print("to less images on contacts, changing max. new max is \(self.contactImg.count) [old \(difficulty)]")
                max = self.contactImg.count
            }
            //use the found contacts as cards
            self.model = MemoryGameModel<UIImage>(numberOfPairsOfCards: max, cardContentFactory: { pairIndex in
                return self.contactImg[pairIndexNumbers[pairIndex]]
            })
        }
        self.loadingContacts = false
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGameModel<UIImage>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGameModel<UIImage>.Card){
        model.choose(card: card)
        gameFinished()
    }
    
    func resetGame(){
        self.createMemoryGame(difficulty:difficulty)
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
            self.setPoints(self.points)
        }
    }
    
    func getPoints()->Int{
        return model.getPoints()
    }
    
}
