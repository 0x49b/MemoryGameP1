import SwiftUI

struct ImageCardView: View{
    
    var card: MemoryGameModel<UIImage>.Card
    
    var body: some View{
        GeometryReader{geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize)-> some View{
        if card.isFaceUp || !card.isMatched{
            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                        
                        Pie(startAngle: Angle(degrees: -circleRotation),
                            endAngle: Angle(degrees: -animatedBonusRemaining * degreesFullCircle - circleRotation),clockwise: true)
                            .onAppear{
                                startBonusTimeAnimation()
                            }
                    }
                    
                    else{
                        Pie(startAngle: Angle(degrees: -circleRotation),
                            endAngle: Angle(degrees: -card.bonusRemaining * degreesFullCircle - circleRotation),clockwise: true)
                    }
                }.padding(5)
                .opacity(opacity)
                
                Image(uiImage: card.content)
                    .resizable()
                    .frame(width: fontSize(for: size), height: fontSize(for: size))
                    cornerRadius(50)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    // MARK: - Drawing Constants
    private let opacity = Double(0.4)
    private let cornerRadius = CGFloat(10)
    private let edgeLineWidth = CGFloat(3)
    private func fontSize(for size: CGSize)->CGFloat{
        min(size.width, size.height) * 0.7
    }
    private let circleRotation = Double(90)
    private let degreesFullCircle = Double(360)
    private let contentRotationDuration = Double(1)
    
}
