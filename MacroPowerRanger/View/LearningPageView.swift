//
//  LearningPage.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/17/21.
//

import SwiftUI

struct LearningPageView: View {
    
    @ObservedObject var learningPageViewModel: LearningPageViewModel
    
    @State var currentIndex: Int = 0
    
    let material = CourseSampleData.courses[0].courseMaterials
    
    var body: some View {
        VStack {
            CustomNavigationView()
            ChatBoxView()
            ZStack {
                Ellipse()
                    .foregroundColor(Color(red: 161/255, green: 159/255, blue: 137/255))
                    .padding()
                HStack {
                    Spacer()
                    SettingButtonsView()
                }
                VStack {
                    Spacer()
                    PrevNextButtonView()
                }
            }
            MaterialSnapPicker(index: $currentIndex, items: material) { material in
                
                GeometryReader { proxy in
                    let scale = getScale(proxy: proxy)
                    
                    ZStack {
                        Circle()
                            .fill(Color(red: 176/255, green: 228/255, blue: 255/255, opacity: 0.5))
                            .frame(width: 35)
                            .clipped()
                        Text(material.title)
                            .padding()
                    }
                    .scaleEffect(.init(width: scale, height: scale))
                }
                
            }.frame(height: 125)
            
            
            
            
        }
    }
//    Text(material.title)
//        .padding()
//        .background(
//            Circle()
//                .fill(Color(red: 176/255, green: 228/255, blue: 255/255, opacity: 0.5))
//                .frame(width: 35)
//                .clipped()
//        )
//        .scaleEffect(.init(width: scale, height: scale))
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).midX
        
        let diff = abs(x - UIScreen.main.bounds.width / 2 - 17.5)
        
        if diff < UIScreen.main.bounds.width - 175 {
            scale = 1 + (UIScreen.main.bounds.width - 200 - diff) / 170
        }
        
        return scale
    }
}



struct LearningPageView_Previews: PreviewProvider {
    static var previews: some View {
        LearningPageView(learningPageViewModel: LearningPageViewModel())
    }
}

struct CustomNavigationView: View {
    
    var body: some View {
        ZStack {
            HStack() {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding()
                    .background (
                        Circle()
                            .foregroundColor(Color(red: 99/255, green: 202/255, blue: 255/255))
                            .frame(width: 40, height: 40)
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
    }
}

struct ChatBoxView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(red: 248/255, green: 193/255, blue: 154/255))
                .frame(height: 80)
                .padding(.vertical)
                .padding(.horizontal, 55)
            
            Text("Bentuk jari tangan seperti bentuk segitiga")
                .multilineTextAlignment(.center)
                .frame(width: 260, height: 80)
        }
        
    }
}

struct SettingButtonsView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.fill")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
            Image(systemName: "timer")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
            Image(systemName: "play.circle")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
            Image(systemName: "repeat")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
        }
        .padding()
    }
}

struct PrevNextButtonView: View {
    
    var body: some View {
        HStack {
            Button {
                print("prev")
            } label: {
                Text("Prev")
                    .foregroundColor(.black)
                    .padding()
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                            .frame(width: 60, height: 30)
                    )
                    .padding(.horizontal)
                
            }
            
            Spacer()
            
            Button {
                print("next")
            } label: {
                Text("Next")
                    .foregroundColor(.black)
                    .padding()
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                            .frame(width: 60, height: 30)
                    )
                    .padding(.horizontal)
            }
        }
    }
}

//struct MaterialPickerView: View {
//
//    @State var index = 0
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color(red: 244/255, green: 244/255, blue: 244/255))
//                .frame(maxWidth: .infinity)
//                .cornerRadius(40, corners: [.topLeft, .topRight])
//                .ignoresSafeArea()
//
//            ScrollView(.horizontal) {
//                HStack(spacing: 80) {
//                    ForEach(0..<10) { index in
//
//                        GeometryReader { proxy in
//                            let scale = getScale(proxy: proxy)
//
//                            Circle()
//                                .fill(Color(red: 176/255, green: 228/255, blue: 255/255, opacity: 0.5))
//                                .frame(width: 35)
//                                .clipped()
//                                .scaleEffect(.init(width: scale, height: scale))
//
//                        }
//                    }
//                }.padding(32)
//            }
//        }
//
//    }
//
//    private func getScale(proxy: GeometryProxy) -> CGFloat {
//        var scale: CGFloat = 1
//
//        let x = proxy.frame(in: .global).midX
//
//        let diff = abs(x - UIScreen.main.bounds.width / 2 + 17.5)
//
//        if diff < UIScreen.main.bounds.width - 175 {
//            scale = 1 + (UIScreen.main.bounds.width - 175 - diff) / 160
//        }
//
//        return scale
//    }
//}
