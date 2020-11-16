import Foundation


class EmojiMemoryGameViewModel: ObservableObject{
    
    @Published private var model: MemoryGameModel<String>
    
    init() {
        model = EmojiMemoryGameViewModel.createMemoryGame()
    }
    
    private static func createMemoryGame()->MemoryGameModel<String>{
        let emojiis: Array<String> = ["🦊","🐶","🐰","🦄","🐧", "🐻", "🐳","🐌","🐡","🐙","🐝","🐼","🐭","🐷","🐮","🐔"]
        
        return  MemoryGameModel<String>(numberOfPairsOfCards: emojiis.count, cardContentFactory: { pairIndex in
            return emojiis[pairIndex]
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
        model = EmojiMemoryGameViewModel.createMemoryGame()
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
        
        print(matched, " ", cardcount)
        
        if(matched == cardcount){
            
        }
    }
}
