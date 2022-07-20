//
//  OnboardingView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 03/11/21.
//

import SwiftUI

struct OnboardingView: View {
    @State private var indexPage = 0
    @Binding var shouldShowOnboarding: Bool
    @State var isHidden = false
    
    var body: some View {
        NavigationView{
            TabView(selection: $indexPage){
                ForEach(0..<onboardingScreens.count){ it in
                    VStack {
                        Image(onboardingScreens[it].bgImage)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 90)
                        Text(onboardingScreens[it].title)
                            .bold()
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 14)
                            
                        Text(onboardingScreens[it].description)
                            .font(.system(size: 16, weight: .light))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,61)
                            
                        
                        Spacer()
                            .frame(minHeight: 10, idealHeight: 100, maxHeight: 600)
                            .fixedSize()
                        
                        ZStack{
                            
                            
                            HStack{
                                if onboardingScreens[it].showsButton {
                                    Button(action: {
                                        shouldShowOnboarding.toggle()
                                        
                                    }, label: {
                                        Text("Mulai")
                                            .bold()
                                            .foregroundColor(Color.white)
                                            .frame(width: 305, height: 45)
                                            .background(Color("MainColor"))
                                        
                                    }).cornerRadius(12)
                                }
                            }
                        }
                    }
                    .tag(it)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
                HStack{
                    ForEach(0..<onboardingScreens.count){ it in
                        if it == indexPage {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("MainColor"))
                        }
                        else {
                            Circle().stroke(Color("MainColor"), lineWidth: 2)
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                            //.border(Color.blue)
                            
                        }
                    }.disabled(indexPage == onboardingScreens.count-1)
                        .opacity(indexPage == onboardingScreens.count-1 ? 0 : 1)
                }.padding(.bottom)
                ,alignment: .bottom
            )
            .toolbar {
                Button(action: {
                    shouldShowOnboarding.toggle()
                }, label: {
                    Text("Lewati")
                        .font(.system(size: 20))
                        .foregroundColor(Color("MainColor"))
                }).disabled(indexPage == onboardingScreens.count-1)
                    .opacity(indexPage == onboardingScreens.count-1 ? 0 : 1)
            }
            
        }
    }
}


        
