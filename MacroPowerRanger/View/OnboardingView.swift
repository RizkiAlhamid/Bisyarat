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
                        Text(onboardingScreens[it].title)
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,32)
                            .padding(.top,10)
                            
                        Text(onboardingScreens[it].description)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,32)
                            .padding(.top,16)
                        
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
                                            .frame(width: 90, height: 40)
                                            .background(Color.blue)
                                        
                                    }).cornerRadius(20)
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
                                .foregroundColor(.blue)
                        }
                        else {
                            Circle().stroke(Color.blue, lineWidth: 2)
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                            //.border(Color.blue)
                            
                        }
                    }
                }.padding(.bottom)
                ,alignment: .bottom
            )
            .toolbar {
                Button(action: {
                    shouldShowOnboarding.toggle()
                }, label: {
                    Text("Skip")
                        .foregroundColor(Color.orange)
                }).disabled(indexPage == onboardingScreens.count-1)
                    .opacity(indexPage == onboardingScreens.count-1 ? 0 : 1)
            }
            
        }
    }
}


        
