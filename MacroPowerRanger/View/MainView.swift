//
//  MainView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 26/10/21.
//

import SwiftUI

struct MainView: View {
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    var body: some View {
        TabView {
            CourseListView()
                .tabItem {
                    Label("Belajar", systemImage: "book.fill")
                }
            PracticeView()
                .tabItem {
                    Label("Latihan", systemImage: "hands.sparkles.fill")
                }.edgesIgnoringSafeArea(.top)
        }
        .navigationBarHidden(true)
                .fullScreenCover(isPresented: $shouldShowOnboarding, content: { OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
            
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
