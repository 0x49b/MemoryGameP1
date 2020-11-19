import SwiftUI


class EmojiMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<String>
    @State var points = UserDefaults.standard.integer(forKey: "points")
    var difficulty = 0
    let defaults = UserDefaults.standard
    var setPoints: ((Int) -> Void)

    
    init(difficulty: Int, setPoints: @escaping ((Int) -> Void)) {
        model = EmojiMemoryGameViewModel.createMemoryGame(difficulty: difficulty)
        points = 0
        self.setPoints = setPoints
        self.difficulty = difficulty
    }
    
    
    private static func createMemoryGame(difficulty: Int)->MemoryGameModel<String>{
        
        let possibleEmojis: Array<String> = ["🦊","🐶","🐰","🦄","🐧", "🐻", "🐳","🐌","🐡","🐙","🐝","🐼","🐭","🐷","🐮","🐔"]
        var emojis: Array<String> = []
        
        print("difficulty set to ", difficulty)
        
        for index in 0..<difficulty{
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
        self.defaults.set(0, forKey: "points")
        model = EmojiMemoryGameViewModel.createMemoryGame(difficulty: self.difficulty)
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
            self.defaults.set(self.points, forKey: "points")
            setHighscore()
            self.setPoints(self.points)
        }
        
    }
            
    func getPoints()->Int{
        return model.getPoints()
    }
    
    func setHighscore(){
        let highscore = self.defaults.integer(forKey: "highscore")
        if(self.points > highscore){
            self.defaults.set(self.points, forKey: "highscore")
        }
    }
    
    
}
