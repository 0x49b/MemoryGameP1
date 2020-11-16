import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    @State var showingSettings = false
    
    var body: some View {
        VStack{
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: cardRotationDuration)){
                        viewModel.choose(card: card)
                    }
                }
                .padding(cardViewPadding)
            }
            HStack{
                Button(action: {
                    withAnimation(.easeInOut(duration: gameResetAnimationDuration)){
                        viewModel.resetGame()
                    }
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                })
                Button(action: {
                    withAnimation(.easeInOut(duration: gameResetAnimationDuration)){
                        self.showingSettings.toggle()
                    }
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                }).sheet(isPresented: $showingSettings) {
                    SettingsView(viewModel: self.viewModel, isPresented: self.$showingSettings)
                }
            }
        }
        .foregroundColor(Color.blue)
    }
}

// MARK: - Drawing Constants
private let cardRotationDuration = Double(0.45)
private let gameResetAnimationDuration = Double(0.5)
private let cardViewPadding = CGFloat(5)

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
