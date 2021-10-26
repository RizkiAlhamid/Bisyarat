//
//  MainView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 26/10/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CourseListView()
                .tabItem {
                    Label("Belajar", systemImage: "book.fill")
                }
            LearningPage()
                .tabItem {
                    Label("Latihan", systemImage: "hands.sparkles.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
