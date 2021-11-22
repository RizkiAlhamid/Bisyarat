//
//  PracticeView.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/22/21.
//

import SwiftUI

struct ChallengeView: View {
    @ObservedObject var challengePageViewModel = ChallengePageViewModel()
    
    var body: some View {
        ZStack {
            CameraView(vm: challengePageViewModel)
        }
//        .toolbar(content: {
//            Button {
//                isGuessedTrue.toggle()
//            } label: {
//                Text("Petunjuk")
//            }
//        })
        .overlay(
            correctBadge
                .animation(.default)
        )
        .overlay(
            timerView
                .animation(.default)
        )
        .overlay(
            handInFrameView
                .animation(.default)
        )
        .onReceive(challengePageViewModel.timer, perform: { time in
            if challengePageViewModel.timeRemaining > 0 && challengePageViewModel.isHandInFrame == true {
                challengePageViewModel.timeRemaining -= 1
            }
        })
        .onAppear(perform: {
            challengePageViewModel.refreshState()
        })
        .navigationTitle("Huruf A")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var correctBadge: some View {
        if challengePageViewModel.isGuessedTrue == true {
        Image(systemName: "checkmark.seal.fill")
          .resizable()
          .imageScale(.large)
          .foregroundColor(.white)
          .frame(width: 200, height: 200)
          .shadow(radius: 5)
      } else {
        EmptyView()
      }
    }
    
    @ViewBuilder
    private var timerView: some View {
        if challengePageViewModel.timeRemaining > 0 && challengePageViewModel.isHandInFrame == true {
            Text("\(challengePageViewModel.timeRemaining)")
                .font(.largeTitle)
                .background(
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .shadow(radius: 5)
                )
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var handInFrameView: some View {
        if challengePageViewModel.isHandInFrame == false {
            Image("GuideHandInFrame")
              .resizable()
              .imageScale(.large)
              .foregroundColor(.white)
              .frame(width: 300, height: 400)
              .shadow(radius: 5)
        } else {
            EmptyView()
        }
    }
    
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
