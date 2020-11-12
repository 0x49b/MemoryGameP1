import SwiftUI

struct Cardify: AnimatableModifier{
    
    var isFaceUp: Bool{
        rotation < 90
    }
    
    var rotation: Double
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double{
        get {return rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 10)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle(degrees: rotation),
                          axis: (0,1,0))
    }
}

extension View{
    
    func cardify(isFaceUp: Bool)-> some View{
        return modifier(Cardify(isFaceUp: isFaceUp))
    }
}
