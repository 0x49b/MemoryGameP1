//
//  SettingsView.swift
//  Emojimory
//
//  Created by Florian Thiévent on 01.10.20.
//

import SwiftUI

struct SettingsTab: View {
    
    @State private var modeSelection = 0
    @State private var fullScreen = false
    private let modes: [String] = ["EASY", "MEDIUM", "HARD"] // easy 6 Items, Medium 12 Items, Hard 18 Items
    @State var showInfo = false
    @State var viewModel: EmojiMemoryGameViewModel
    
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center, spacing: 75){
                
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
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                    
                    VStack{
                        
                        NavigationLink(
                            destination: EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel()),
                            label: {
                                VStack{
                                    Text("START_GAME")
                                        .foregroundColor(Color.black)
                                        .frame(width: 230, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }.padding(7)
                            }
                        )
                  
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                        Spacer()
                        
                        Button(action: {
                            self.showInfo.toggle()
                        }, label: {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.black)
                        }).sheet(isPresented: $showInfo) {
                            InfoView(showInfo: self.$showInfo)
                        }
                        
                }
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
        
    }
}


struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
       SettingsTab(viewModel:  EmojiMemoryGameViewModel())
    }
}

