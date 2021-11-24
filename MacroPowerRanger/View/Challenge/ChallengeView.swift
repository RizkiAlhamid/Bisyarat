//
//  PracticeView.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/22/21.
//

import SwiftUI

struct ChallengeView: View {
    @ObservedObject var challengePageViewModel = ChallengePageViewModel()
    @State private var showingAlert = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            CameraView(vm: challengePageViewModel)
            VStack {
                Text("00:0\(challengePageViewModel.guestTimer)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .frame(width: 140, height: 40)
                    )
                    .padding(.vertical)
                Spacer()
                progressBarView
            }
        }
        //        .toolbar(content: {
        //            Button {
        //                isGuessedTrue.toggle()
        //            } label: {
        //                Text("Petunjuk")
        //            }
        //        })]
        .overlay(
            handInFrameView
                .animation(.default)
        )
        .overlay(
            startTimerView
                .animation(.default)
        )
        .overlay(
            questionBadge
                .animation(.default)
        )
        .overlay(
            correctBadge
                .animation(.default)
        )
        .overlay(
            timesUpBadge
                .animation(.default)
        )
        .overlay(
            ChallengeFinishedView(challengePageViewModel: challengePageViewModel)
        )
        .onReceive(challengePageViewModel.timer, perform: { time in
            if challengePageViewModel.startTimer > 0 && challengePageViewModel.isHandInFrame == true {
                challengePageViewModel.startTimer -= 1
            }
            if challengePageViewModel.guestTimer > 0 && challengePageViewModel.shouldStartClassifying == true {
                challengePageViewModel.guestTimer -= 1
            }
        })
        .onChange(of: challengePageViewModel.startTimer, perform: { newValue in
            if newValue <= 0 {
                challengePageViewModel.shouldShowQuestion = true
            } else {
                challengePageViewModel.shouldStartClassifying = false
            }
        })
        .onChange(of: challengePageViewModel.guestTimer, perform: { newValue in
            if newValue <= 0 {
                challengePageViewModel.isTimesUp = true
                challengePageViewModel.shouldStartClassifying = false
            } else {
                //challengePageViewModel.shouldStartClassifying = true
            }
        })
        .onChange(of: challengePageViewModel.isGuessedTrue, perform: { newValue in
            if newValue == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    challengePageViewModel.nextMaterial()
                }
            }
        })
        .onChange(of: challengePageViewModel.isTimesUp, perform: { newValue in
            if newValue == true && challengePageViewModel.isGuessedTrue == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    challengePageViewModel.nextMaterial()
                }
            }
        })
        .onChange(of: challengePageViewModel.shouldShowQuestion, perform: { newValue in
            if newValue == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    challengePageViewModel.shouldStartClassifying = true
                    challengePageViewModel.shouldShowQuestion = false
                }
            }
        })
        .onChange(of: challengePageViewModel.dismissChallenge, perform: { newValue in
            if newValue == true {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .onAppear(perform: {
            challengePageViewModel.refreshState()
            UIApplication.shared.isIdleTimerDisabled = true
        })
        .onDisappear(perform: {
            UIApplication.shared.isIdleTimerDisabled = false
        })
        .navigationTitle("Huruf \(challengePageViewModel.challengeMaterials[challengePageViewModel.materialIndex].title)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var correctBadge: some View {
        if challengePageViewModel.isGuessedTrue == true {
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
    
    @ViewBuilder
    private var timesUpBadge: some View {
        if challengePageViewModel.isTimesUp == true && challengePageViewModel.isGuessedTrue == false {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 38/255, green: 0, blue: 0, opacity: 0.5))
                    .opacity(0.5)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea(.all)
                VStack {
                    Image("\(challengePageViewModel.challengeMaterials[challengePageViewModel.materialIndex].title)")
                        .resizable()
                        .imageScale(.large)
                        //.frame(width: 200, height: 200)
                        .shadow(radius: 5)
                    Text("Gerakan yang benar begini ya")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .font(.title)
                }
                .frame(width: 325, height: 325)
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var questionBadge: some View {
        if challengePageViewModel.shouldShowQuestion == true {
            Text("Huruf \(challengePageViewModel.materialBeingAsked)")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.title)
                .background(
                    Rectangle()
                        .cornerRadius(16)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                )
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var startTimerView: some View {
        if challengePageViewModel.startTimer > 0 && challengePageViewModel.isHandInFrame == true {
            Text("\(challengePageViewModel.startTimer)")
                .font(.largeTitle)
                .foregroundColor(.black)
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
    
    private var progressBarView: some View {
        VStack {
            Text("\(challengePageViewModel.materialIndex)/\(challengePageViewModel.challengeMaterials.count)")
                .foregroundColor(.white)
                .font(.system(size: 24))
                .padding(.vertical, 5)
                .padding(.horizontal, 35)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black)
                        .opacity(0.2)
                )
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 20)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("MainColor"))
                    .frame(width: 300 * challengePageViewModel.currentProgress, height: 20)
            }
        }
        .padding(.vertical)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
