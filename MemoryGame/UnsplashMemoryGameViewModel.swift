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
    var setPoints: ((Int) -> Void)
    
    struct UnsplashImages: Decodable{
        let urls: Dictionary<String, String>
    }
    
    init(difficulty: Int, setPoints: @escaping ((Int) -> Void)) {
        model = MemoryGameModel<UIImage>(numberOfPairsOfCards: 0, cardContentFactory: { pairIndex in return UIImage() })
        self.difficulty = difficulty
        self.setPoints = setPoints
    }
    
    private static func createMemoryGame(difficulty: Int)->MemoryGameModel<UIImage>{
        print("difficulty set to ", difficulty)
        return MemoryGameModel<UIImage>(numberOfPairsOfCards: 0, cardContentFactory: { pairIndex in return UIImage() })
    }
    
    //https://www.hackingwithswift.com/forums/swiftui/loading-images/3292
    func loadUnsplashImages(difficulty: Int){
        
        loadingImages = true
        unsplashImages.removeAll()
        
        let composedURL = "\(self.unsplashBaseUrl)\(self.clientID)&count=\(String(difficulty))"
        print(composedURL)
        if let imageURL = URL(string: composedURL){
            
            self.dispatchGroup.enter()
            URLSession.shared.dataTask(with: imageURL){ (data, response, error) in
                if let data = data {
                    do{
                        for i in 0..<difficulty{
                            
                            print(i)
                            
                            self.dispatchGroup.enter()
                            let resp = try JSONDecoder().decode([UnsplashImages].self, from: data)
                            let imageURL_ = URL(string: resp[i].urls["small"]!)
                            
                            print(imageURL_?.absoluteURL)
                            
                            if let imageLocation = imageURL_{
                                print(imageLocation)
                                DispatchQueue.global(qos: .userInitiated).async {
                                    if let image = try? Data(contentsOf: imageLocation){
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
        }
            
            
            print("imageCount \(self.unsplashImages.count)")
            
            dispatchGroup.notify(queue: .main){[self] in
                print("imageCount \(self.unsplashImages.count)")
                
                model = MemoryGameModel<UIImage>(numberOfPairsOfCards: difficulty, cardContentFactory: { pairIndex in
                    print(pairIndex)
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
        print("call for reset game. difficulty \(difficulty)")
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
            self.setPoints(self.points)
        }
    }
    
    func getPoints()->Int{
        return model.getPoints()
    }
    
}
