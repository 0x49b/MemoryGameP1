//
//  TabBarView.swift
//  MemoryGame
//
//  Created by Florian Thiévent on 15.11.20.
//  Copyright © 2020 fhnw. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    // Hold the state for which tab is active/selected
    @State var selection: Int = 0
    
    var body: some View {
        
        // Your native TabView here
        TabView(selection: $selection) {
            EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
                .tag(0)
            
            FavoritesTab()
                .tag(1)
            
            SettingsTab()
                .tag(2)
        }
        .overlay( // Overlay the custom TabView component here
            Color.white // Base color for Tab Bar
                .edgesIgnoringSafeArea(.vertical)
                .frame(height: 50) // Match Height of native bar
                .overlay(HStack {
                    Spacer()
                    
                    // First Tab Button
                    Button(action: {
                        self.selection = 0
                    }, label: {
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                            .opacity(selection == 0 ? 1 : 0.4)
                    })
                    Spacer()
                    
                    // Second Tab Button
                    Button(action: {
                        self.selection = 1
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                            .opacity(selection == 1 ? 1 : 0.4)
                    })
                    
                    Spacer()
                    
                    // Third Tab Button
                    Button(action: {
                        self.selection = 2
                    }, label: {
                        Image(systemName: "gear")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                            .opacity(selection == 2 ? 1 : 0.4)
                    })
                    Spacer()
                
                })
        ,alignment: .bottom) // Align the overlay to bottom to ensure tab bar stays pinned.
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
