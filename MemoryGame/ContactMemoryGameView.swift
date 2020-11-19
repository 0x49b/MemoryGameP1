import SwiftUI

struct ContactMemoryGameView: View {
    
    @ObservedObject var viewModel: ContactMemoryGameViewModel
    @State var showingSettings = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var loading: Bool = false
    
    var body: some View {
        VStack{
            

            if(viewModel.loadingContacts){
                Text("loading contacts")
            } else {
            
            
            Grid(viewModel.cards) { card in
                ImageCardView(card: card).onTapGesture {
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
                    Text(String(self.viewModel.getPoints()))
                }.foregroundColor(.black)
            }
        
        }
        
        }
        .foregroundColor(Color.blue)
        
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
    
}

private let cardRotationDuration = Double(0.45)
private let gameResetAnimationDuration = Double(0.5)
private let cardViewPadding = CGFloat(5)

struct ContactMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        ContactMemoryGameView(viewModel: ContactMemoryGameViewModel(difficulty:3))
    }
}
