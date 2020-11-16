//
//  InfoView.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 15.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    
    @Binding var showInfo: Bool
    
    var body: some View {
        
        VStack(alignment: .center){
        
            /*VStack(alignment: .trailing){
                ZStack(alignment: .topTrailing) {
                            Color.clear
                            VStack(alignment: .leading) {
                                Button(action: {self.showInfo.toggle()} , label: {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                                })
                            }
                }.frame(maxWidth: .infinity, maxHeight: 0).padding(10)
            }*/
            VStack(alignment: .center){
                
                Text("🤷🏻‍♂️").font(.system(size:80))
                Text("MemoryGame").font(Font.custom("Couture-Bold", size: 25))
                VStack{
                    Text("DEV_INFO")
                        .multilineTextAlignment(.center)
                        .font(.system(size:10))
                }
                
            }
        }
    }
}


/*struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}*/
