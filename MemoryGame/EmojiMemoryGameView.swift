import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    @State var showingSettings = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var points = UserDefaults.standard.integer(forKey: "points")
    
    
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
                    viewModel.resetGame()
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                })
                
                               
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                }).sheet(isPresented: $showingSettings) {
                    SettingsView()
                }.opacity(1)
                
                
                HStack{
                    Text("POINTS_LABEL")
                    Text(String(points))
                }.foregroundColor(.black)
            }
        }
        .foregroundColor(Color.blue)
        .navigationBarHidden(true)
        .navigationBarTitle("")

    }
}

// MARK: - Drawing Constants
private let cardRotationDuration = Double(0.45)
private let gameResetAnimationDuration = Double(0.5)
private let cardViewPadding = CGFloat(5)
