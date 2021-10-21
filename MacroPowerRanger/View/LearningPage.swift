//
//  LearningPage.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/17/21.
//

import SwiftUI

struct LearningPage: View {
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            ZStack {
                HStack() {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 30))
                        .padding()
                        .background (
                            Circle()
                                .foregroundColor(Color(red: 195/255, green: 129/255, blue: 111/255))
                        )
                        .padding(.horizontal, 15)
                    Spacer()
                }
                HStack {
                    Text("Dasar 1")
                        .font(.system(size: 30))
                        .padding(.horizontal, 60)
                }
            }
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(red: 161/255, green: 159/255, blue: 137/255))
                .frame(height: 80)
                .padding(.vertical)
                .padding(.horizontal, 60)
            
            ZStack {
                HStack {
                    Circle()
                        .foregroundColor(Color(red: 161/255, green: 159/255, blue: 137/255))
                        .padding()
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Circle()
                            .frame(width: 41, height: 41)
                        Circle()
                            .frame(width: 41, height: 41)
                        Circle()
                            .frame(width: 41, height: 41)
                        Circle()
                            .frame(width: 41, height: 41)
                    }
                    .padding()
                }
            }
            
            wordCarousel()
                .frame(height: 150)
//            ScrollView(.horizontal) {
//                HStack {
//                    Circle()
//                        .frame(width: 50, height: 50)
//                    Circle()
//                        .frame(width: 50, height: 50)
//                    Circle()
//                        .frame(width: 50, height: 50)
//                }
//            }
            
        }
        
    }
}



struct LearningPage_Previews: PreviewProvider {
    static var previews: some View {
        LearningPage()
    }
}


struct wordCarousel: View {
    
    @State var index = 0
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 80) {
                ForEach(0..<10) {index in
                    
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        
                        Circle()
                            .frame(width: 35)
                            .clipped()
                            .scaleEffect(.init(width: scale, height: scale))
                        
                    }
                }
            }.padding(32)
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).midX

        let diff = abs(x - UIScreen.main.bounds.width / 2 + 17.5)
        
        if diff < UIScreen.main.bounds.width - 175 {
            scale = 1 + (UIScreen.main.bounds.width - 175 - diff) / 160
        }
        
        return scale
    }
}
