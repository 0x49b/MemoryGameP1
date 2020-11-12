//
//  SettingsView.swift
//  Emojimory
//
//  Created by Florian Thiévent on 01.10.20.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var modeSelection = 0
    private let modes: [String] = ["😇", "😀", "😡"]
    
    
    var body: some View {
        VStack{
            Spacer()
            Text("🤷🏻‍♂️").font(.system(size:80))
            Text("MemoryGame").font(Font.custom("Couture-Bold", size: 25))
            VStack{
                Text("Emoji Memory Game developed for iOS Course @ FHNW\nby Roger Kreienbühl & Florian Thiévent")
                    .multilineTextAlignment(.center)
                    .font(.system(size:10))
            }
            // Here Button
            VStack{
                Text("SELECT_MODE")
                Picker(selection: $modeSelection, label: Text("")){
                    ForEach(0..<modes.count, id: \.self){ index in
                        Text(self.modes[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }.padding(.top, 10)
 
            
            
            Spacer()
            VStack(alignment: .center) {
                Image(systemName: "arrow.down").font(.system(size: 25)).padding(.bottom, 5)
                Text("START_GAME")
            }
        }.padding(10)
    }
}
    

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
