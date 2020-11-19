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
    
    
    
    init(difficulty: Int) {
        model = MemoryGameModel<UIImage>(numberOfPairsOfCards: 0, cardContentFactory: { pairIndex in return UIImage() })
        points = 0
        self.difficulty = difficulty
    }
    
    // developer.apple.com/documentation/contacts
    // https://medium.com/better-programming/build-a-swiftui-contacts-search-application-d41b414fe046
    public func createMemoryGame(difficulty: Int)->MemoryGameModel<UIImage>{
        
        loadingContacts = true
        
        let contactStore = CNContactStore()
        let dispatchGroup = DispatchGroup()
        var contactImg: [UIImage] = [UIImage]()
        
        contactStore.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            
            
            if granted {
                let request = CNContactFetchRequest(keysToFetch: [CNContactImageDataKey as CNKeyDescriptor])
                
                request.sortOrder = .givenName
                
                do {
                    try contactStore.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            if let imageData = contact.imageData{
                                dispatchGroup.enter()
                                DispatchQueue.main.async {
                                    contactImg.append(UIImage(data: imageData) ?? UIImage())
                                    print("found a profile photo")
                                    dispatchGroup.leave()
                                }
                            }
                        }
                    })
                    
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
                
                dispatchGroup.notify(queue: .main) {
                    var max = difficulty
                    if(difficulty>contactImg.count){
                        print("to less images on contacts, changing max")
                        max = contactImg.count
                    }
                    //use the found contacts as cards
                    self.model = MemoryGameModel<UIImage>(numberOfPairsOfCards: max, cardContentFactory: { pairIndex in
                        return contactImg[pairIndex]
                    })
                }
            }
        }
        
        loadingContacts = false
        
        return model
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
        model = self.createMemoryGame(difficulty:difficulty)
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
