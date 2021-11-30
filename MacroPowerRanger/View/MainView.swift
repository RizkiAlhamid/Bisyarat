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
    
    
    var body: some View {
        NavigationView {
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
