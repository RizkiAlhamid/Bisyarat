//
//  PracticeView.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/25/21.
//

import SwiftUI

struct PracticeView: View {
    
    @ObservedObject var practicePageViewModel: PracticePageViewModel
    
    var body: some View {
        ZStack {
            PracticeCameraView(vm: practicePageViewModel)
        }
        .toolbar(content: {
            Button {
                practicePageViewModel.isShowingOutline.toggle()
            } label: {
                Text("Petunjuk")
            }
        })
        .overlay(
            outlineView
                .animation(.default)
        )
        .overlay(
            correctBadge
                .animation(.default)
        )
        .onChange(of: practicePageViewModel.isGuessedTrue, perform: { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    practicePageViewModel.isGuessedTrue = false
                }
            }
        })
        .onAppear {
            practicePageViewModel.refreshState()
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear(perform: {
            UIApplication.shared.isIdleTimerDisabled = false
        })
        .navigationTitle("Latihan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var outlineView: some View {
        if practicePageViewModel.isShowingOutline {
            Image("\(practicePageViewModel.materialPractice.title)")
                .resizable()
                .imageScale(.large)
                .frame(width: 325, height: 325)
                .shadow(radius: 5)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var correctBadge: some View {
        if practicePageViewModel.isGuessedTrue == true {
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea(.all)
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 200)
                    .shadow(radius: 5)
            }
        } else {
            EmptyView()
        }
    }
    
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(practicePageViewModel: PracticePageViewModel())
    }
}
