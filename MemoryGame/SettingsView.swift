//
//  SettingsView.swift
//  Emojimory
//
//  Created by Florian Thiévent on 01.10.20.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    @Binding var isPresented: Bool
    @State private var modeSelection = 0
    private let modes: [String] = ["EASY", "MEDIUM", "HARD"]
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 75){
            
            VStack{
                Text("🤷🏻‍♂️").font(.system(size:30))
                Text("MemoryGame").font(Font.custom("Couture-Bold", size: 25))
                VStack{
                    Text("DEV_INFO")
                        .multilineTextAlignment(.center)
                        .font(.system(size:10))
                }
            }
                        
            VStack(spacing: 15){
                
            
                VStack{
                    Text("POINTS_LABEL").font(.system(size:25))
                    Text("0").font(.system(size: 35))
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
                
                VStack{
                    Text("SELECT_IMAGES")
                    
                    HStack{
                        // Emoji
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            VStack{
                                Image("monkey")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                Text("Emojis")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                  
                        // Contacts
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            VStack{
                                Image("contacts")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                Text("CONTACTS")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        }).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                            
                        // Unsplash
                        Button(action: {
                            
                        }, label: {
                            VStack{
                                Image("unsplash")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                Text("Unsplash")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        }).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                            
                    }
                }
                
                VStack{
                    Button(action: {
                        isPresented.toggle()
                        viewModel.resetGame()
                    }, label: {
                        VStack{
                            Text("START_GAME")
                                .foregroundColor(Color.black)
                                .frame(width: 230, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }.padding(7)
                    }).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
            }
            
        }
    }
}
