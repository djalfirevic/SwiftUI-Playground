//
//  ContentView.swift
//  Neumorphic
//
//  Created by Djuro Alfirevic on 6/29/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        let cornerRadius : CGFloat = 15
        Neumorphic.shared.colorScheme = colorScheme
        let mainColor = Neumorphic.shared.mainColor()
        let secondaryColor = Neumorphic.shared.secondaryColor()
        
        return ZStack {
            mainColor.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 30) {
                Text("Neumorphic Soft UI").font(.headline).foregroundColor(secondaryColor)
                HStack(spacing: 40){
                    RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 150, height: 150)
                        .softInnerShadow(RoundedRectangle(cornerRadius: cornerRadius))
                    
                    Circle().fill(mainColor).frame(width: 150, height: 150)
                        .softInnerShadow(Circle())
                }
                
                HStack(spacing: 40) {
                    ZStack {
                        Circle().fill(mainColor)
                            .softInnerShadow(Circle(), spread: 0.6)
                        
                        Circle().fill(mainColor).frame(width: 80, height: 80)
                            .softOuterShadow(offset: 8, radius: 8)
                    }.frame(width: 150, height: 150)
                    
                    ZStack {
                        Circle().fill(mainColor)
                            .softOuterShadow()
                        
                        Circle().fill(mainColor).frame(width: 80, height: 80)
                            .softInnerShadow(Circle(), radius: 5)
                    }.frame(width: 150, height: 150)
                }
                
                HStack(spacing: 30) {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 90, height: 90)
                        .softOuterShadow()
                    
                    RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 90, height: 90)
                        .softInnerShadow(RoundedRectangle(cornerRadius: cornerRadius))
                    
                    Rectangle().fill(mainColor).frame(width: 90, height: 90)
                        .softOuterShadow()
                }
                
                Button(action: {}) {
                    Text("Soft Button").fontWeight(.bold).frame(width: 300, height:20)
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
                
                HStack(spacing: 30) {
                    Button(action: {}) {
                        Image(systemName: "heart.fill")
                    }.softButtonStyle(Circle())
                    
                    Button(action: {}) {
                        Text("Thanks").fontWeight(.bold).frame(width: 150, height: 20)
                    }.softButtonStyle(Ellipse())
                    
                    Button(action: {}) {
                        Image(systemName: "heart.fill")
                    }.softButtonStyle(Circle(), mainColor: Color.red, textColor: Color.white, darkShadowColor: Color(rgb: 0x993333, alpha: 1), lightShadowColor:Color("redButtonLightShadow"))
                }
                 
                Text("Twitter @djalfirevic").font(.footnote).foregroundColor(secondaryColor)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ContentView()
              .environment(\.colorScheme, .light)

           ContentView()
              .environment(\.colorScheme, .dark)
        }
    }
}
