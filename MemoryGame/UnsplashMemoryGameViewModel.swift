//
//  UnsplashMemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 16.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import SwiftUI

class UnsplashMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<UIImage>
    @Published var loadingImages: Bool = false
    
    let clientID = "iUquyXDAT6u2DujQiBpKOPsxF8OBr-gloj9KcV_kB7w"
    let unsplashBaseUrl = "https://api.unsplash.com/photos/random/?client_id="
    var unsplashImages: [UIImage] = [UIImage]()
    var dispatchGroup = DispatchGroup()
    var difficulty: Int
    @State var points = UserDefaults.standard.integer(forKey: "points")
    
    struct UnsplashImages: Decodable{
        let urls: Dictionary<String, String>
    }
    
    init(difficulty: Int) {
        model = MemoryGameModel<UIImage>(numberOfPairsOfCards: 0, cardContentFactory: { pairIndex in return UIImage() })
        self.difficulty = difficulty
    }
    
    private static func createMemoryGame(difficulty: Int)->MemoryGameModel<UIImage>{
        return MemoryGameModel<UIImage>(numberOfPairsOfCards: 0, cardContentFactory: { pairIndex in return UIImage() })
    }
    
    //https://www.hackingwithswift.com/forums/swiftui/loading-images/3292
    func loadUnsplashImages(difficulty: Int){
        
        loadingImages = true
        
        if let imageURL = URL(string: "\(self.unsplashBaseUrl)\(self.clientID)&count=\(String(difficulty))"){
            
            self.dispatchGroup.enter()
            URLSession.shared.dataTask(with: imageURL){ (data, response, error) in
                if let data = data {
                    do{
                        for image in 0..<difficulty{
                            self.dispatchGroup.enter()
                            let resp = try JSONDecoder().decode([UnsplashImages].self, from: data)
                            let imageURL = URL(string: resp[image].urls["small"]!)
                            if let imageURL = imageURL{
                                DispatchQueue.global(qos: .userInitiated).async {
                                    if let image = try? Data(contentsOf: imageURL){
                                        DispatchQueue.main.async {
                                            self.unsplashImages.append(UIImage(data: image)!)
                                            self.dispatchGroup.leave()
                                        }
                                    }
                                }
                            }
                            self.dispatchGroup.leave()
                        }
                    } catch{
                        print("noot noot")
                    }
                }
            }.resume()
            
            print("imageCount \(self.unsplashImages.count)")
            
            model = MemoryGameModel<UIImage>(numberOfPairsOfCards: difficulty, cardContentFactory: { pairIndex in
                return self.unsplashImages[pairIndex]
                
            })
            loadingImages = false
        }
        
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
        print("call for reset game")
        self.loadUnsplashImages(difficulty: self.difficulty)
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
