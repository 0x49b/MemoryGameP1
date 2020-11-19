//
//  UnsplashMemoryGameView.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 18.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import SwiftUI

struct UnsplashMemoryGameView: View {
    
    @ObservedObject var viewModel: UnsplashMemoryGameViewModel
    @State var showingSettings = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var loading: Bool = false
    
    var body: some View {
        VStack{
            
            
            if(viewModel.loadingImages){
                Text("loading images")
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


struct UnsplashMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashMemoryGameView(viewModel: UnsplashMemoryGameViewModel(difficulty: 2))
    }
}
