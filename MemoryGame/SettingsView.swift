//
//  SettingsView.swift
//  Emojimory
//
//  Created by Florian Thiévent on 01.10.20.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var modeSelection = 0
    @State private var showNavBar = false
    private let modes: [String] = ["EASY", "MEDIUM", "HARD"]
    @State var showInfo = false
    @State var gameModel = 0
    @State var difficulty = 1
    @State var points = 0
    let defaults = UserDefaults.standard
    
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .center, spacing: 75){
                
                VStack{
                    Text("POINTS_LABEL").font(.system(size:45))
                    Text(String(defaults.integer(forKey: "points"))).font(.system(size: 55))
                    
                    HStack{
                        Text("Highscore: ")
                        Text(String(defaults.integer(forKey: "highscore")))
                    }.font(.system(size:25))
                }
                
                VStack{
                    Text("SELECT_MODE").font(.system(size: 25))
                    HStack{
                        // Easy
                        Button(action: {
                            self.difficulty = 0
                        }, label: {
                            VStack{
                                Text("EASY")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .border(Color.white.opacity(0.0), width:1)
                        .frame(width:100, height: 50)
                        .background(self.difficulty == 0 ? Color.gray.opacity(0.4) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                            
                        )
                        
                        // Normal
                        Button(action: {
                            self.difficulty = 1
                        }, label: {
                            VStack{
                                Text("NORMAL")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .border(Color.white.opacity(0.0), width:1)
                        .frame(width:100, height: 50)
                        .background(self.difficulty == 1 ? Color.gray.opacity(0.4) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                        // Hard
                        Button(action: {
                            self.difficulty = 2
                        }, label: {
                            VStack{
                                Text("HARD")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .border(Color.white.opacity(0.0), width:1)
                        .frame(width:100, height: 50)
                        .background(self.difficulty == 2 ? Color.gray.opacity(0.4) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }.padding(.leading, HORIZONTAL_PADDING).padding(.trailing, HORIZONTAL_PADDING)
                }
                
                VStack{
                    Text("SELECT_IMAGES").font(.system(size: 25))
                    
                    HStack{
                        // Emoji
                        Button(action: {
                            self.gameModel = 0
                        }, label: {
                            VStack{
                                Image("monkey")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                Text("Emojis")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .border(Color.white.opacity(0.0), width:1)
                        .frame(width: 100, height: 100)
                        .background(self.gameModel == 0 ? Color.gray.opacity(0.4) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                            
                        )
                        
                        // Contacts
                        Button(action: {
                            self.gameModel = 1
                        }, label: {
                            VStack{
                                Image("contacts")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                Text("CONTACTS")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .border(Color.white.opacity(0.0), width:1)
                        .frame(width: 100, height: 100)
                        .background(self.gameModel == 1 ? Color.gray.opacity(0.4) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                        // Unsplash
                        Button(action: {
                            self.gameModel = 2
                        }, label: {
                            VStack{
                                Image("unsplash")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                Text("Unsplash")
                                    .foregroundColor(Color.black)
                            }.padding(7)
                        })
                        .border(Color.white.opacity(0.0), width:1)
                        .frame(width: 100, height: 100)
                        .background(self.gameModel == 2 ? Color.gray.opacity(0.4) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    
                    VStack{
                        NavigationLink(
                            destination:
                                setGameView(),
                            label: {
                                VStack{
                                    Text("START_GAME")
                                        .foregroundColor(Color.black)
                                        .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
        .navigationBarHidden(self.showNavBar)
        .navigationBarTitle("")
        
    }
    
    func setPoints (points: Int) -> Void {
        self.points = points
    }
    
    
    
    //MARK: Items for each level
    private let EASY = 3
    private let NORMAL = 8
    private let HARD = 16
    private let HORIZONTAL_PADDING = CGFloat(20)
    
    private func numbersOfItems()->Int{
        if(self.difficulty == 0){
            return  EASY
        } else if (self.difficulty == 1){
            return  NORMAL
        } else if (self.difficulty == 2){
            return  HARD
        }
        return 0
    }
    
    
    @ViewBuilder
    private func setGameView()->some View{
        let highScore: ((Int) -> Void) = setPoints
        if( self.gameModel == 0){
            EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel(difficulty: numbersOfItems(), setPoints: highScore))
        }else if(self.gameModel == 1){
            ContactMemoryGameView(viewModel: ContactMemoryGameViewModel(difficulty: numbersOfItems(), setPoints: highScore))
        }else if(self.gameModel == 2){
            UnsplashMemoryGameView(viewModel: UnsplashMemoryGameViewModel(difficulty: numbersOfItems(), setPoints: highScore))
        }
    }
    
    
}


struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
