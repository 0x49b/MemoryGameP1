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
        VStack{
            Text("🤷🏻‍♂️").font(.system(size:80))
            Text("MemoryGame").font(Font.custom("Couture-Bold", size: 25))
            VStack{
                Text("DEV_INFO")
                    .multilineTextAlignment(.center)
                    .font(.system(size:10))
            }
            
            Button("Dismiss") {
                        self.showInfo.toggle()
                    }
        }
    }
}
