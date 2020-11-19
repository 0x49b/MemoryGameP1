import SwiftUI


class EmojiMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<String>
    @State var points: Int
    var difficulty = 0
    let defaults = UserDefaults.standard
    var setHighscore: ((Int) -> Void)

    
    init(difficulty: Int, setHighscore: @escaping ((Int) -> Void)) {
        model = EmojiMemoryGameViewModel.createMemoryGame(difficulty: difficulty)
        self.points = 0
        self.setHighscore = setHighscore
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
        self.gameFinished()
    }
    
    func resetGame(){
        model = EmojiMemoryGameViewModel.createMemoryGame(difficulty: self.difficulty)
    }
    
    func gameFinished(){
        let pts = model.getPoints()
        print(model.getPoints())
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
            print("points: \(pts)")
            self.setHighscore(pts)
        }
        
    }
            
    func getPoints()->Int{
        return model.getPoints()
    }
    
}
