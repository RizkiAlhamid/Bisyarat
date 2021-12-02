//
//  MainView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 26/10/21.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @State private var tag: Int = 1
    @State var animate = false
    @State var endSplash = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        ZStack {
            NavigationView {
                if horizontalSizeClass == .compact {
                    TabView(selection: $tag) {
                        CourseListView()
                            .tabItem {
                                Label("Belajar", systemImage: "book.fill")
                            }.tag(1)
                        ChallengeListView()
                            .tabItem {
                                Label("Tantangan", systemImage: "flag.2.crossed.fill")
                            }.tag(2)
                    }
                    .navigationTitle(tag == 1 ? "Belajar" : "Tantangan")
                    .fullScreenCover(isPresented: $shouldShowOnboarding, content: { OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                        
                    })
                } else {
                    EmptyView()
                    TabView(selection: $tag) {
                        CourseListView()
                            .tabItem {
                                Label("Belajar", systemImage: "book.fill")
                            }.tag(1)
                        ChallengeListView()
                            .tabItem {
                                Label("Tantangan", systemImage: "flag.2.crossed.fill")
                            }.tag(2)
                    }
                    .navigationTitle(tag == 1 ? "Belajar" : "Tantangan")
                    .fullScreenCover(isPresented: $shouldShowOnboarding, content: { OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                        
                    })
                }
            }
            
            ZStack {
                Color("LaunchScreenBg")
                
                Image("bisyaratLarge")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 104, height: animate ? nil : 121)
                    .scaleEffect(animate ? 3 : 1)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animateSplash() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.easeOut(duration: 0.45)) {
                animate.toggle()
            }
            
            withAnimation(Animation.easeOut(duration: 0.35)) {
                endSplash.toggle()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
