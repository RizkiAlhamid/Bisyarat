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
    @State private var isPresenting = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let images: [Image] = {
        var images: [Image] = [Image("Tantangan-\(0)")]
        for number in 1...59 {
            images.append(Image("Tantangan-\(number)"))
        }
        return images
    }()
    
    var body: some View {
        ZStack {
            CameraView(vm: challengePageViewModel)
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
                    AnimatingImage(images: images, vm: challengePageViewModel)
                        .animation(.default)
                )
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
                    .opacity(challengePageViewModel.shouldShowQuestion || challengePageViewModel.shouldStartClassifying ? 1 : 0)
                Spacer()
                progressBarView
                    .opacity(challengePageViewModel.isGuessedTrue || challengePageViewModel.isTimesUp ? 1 : 0)
            }
        }
        .fullScreenCover(isPresented: $isPresenting, onDismiss: {
            
        }, content: {
            ChallengeFinishedView(challengePageViewModel: challengePageViewModel, isPresenting: $isPresenting)
        })
        .onChange(of: challengePageViewModel.currentProgress , perform: { newValue in
            if newValue == 1 {
                isPresenting = true
            }
        })
        .onReceive(challengePageViewModel.timer, perform: { time in
            if challengePageViewModel.startTimer > 0 && challengePageViewModel.isHandInFrame == true && challengePageViewModel.showTutorial == false {
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
            if challengePageViewModel.challengeTitle == "Alfabet 2" && challengePageViewModel.continueChallenge {
                challengePageViewModel.fetchChallengeMaterials(challenge: ChallengeSampleData.challenges[0])
                challengePageViewModel.continueChallenge = false
            }
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
                Circle()
//                    .resizable()
//                    .imageScale(.large)
                    .foregroundColor(.white)
                    .frame(width: 160, height: 160)
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .imageScale(.large)
                    .foregroundColor(Color("MainColor"))
                    .frame(width: 200, height: 200)
                    //.shadow(radius: 5)
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
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.title)
                .background(
                    Rectangle()
                        .cornerRadius(16)
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color("BadgeBgColor"))
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
                .foregroundColor(.primary)
                .background(
                    Circle()
                        .foregroundColor(Color("BadgeBgColor"))
                        .frame(width: 200, height: 200)
                        .shadow(radius: 5)
                )
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var handInFrameView: some View {
        if challengePageViewModel.isHandInFrame == false && challengePageViewModel.showTutorial == false{
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
            Text("\(challengePageViewModel.materialIndex + 1)/\(challengePageViewModel.challengeMaterials.count)")
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
                    .frame(width: 300 * challengePageViewModel.getUserProgress(), height: 20)
            }
        }
        .padding(.vertical)
    }
}

struct AnimatingImage: View {
    let images: [Image]

    @ObservedObject private var counter = Counter(interval: 0.05)
    @ObservedObject var vm: ChallengePageViewModel
    
    var body: some View {
        if vm.showTutorial {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 1))
                    .opacity(1)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea(.all)
                
                VStack {
                    images[counter.value % images.count]
                        .resizable()
                        .frame(height: 400)
                    Text("Buat gerakan isyarat sesuai huruf atau kata yang muncul di layar")
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                    Button {
                        vm.showTutorial.toggle()
                    } label: {
                        Text("Mulai")
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 120, height: 60)
                                    .foregroundColor(.init(red: 196/255, green: 196/255, blue: 196/255))
                            )
                    }.padding()
                }.frame(width: 300, height: 625)
                .offset(y: 50)
            }
        } else {
            EmptyView()
        }
    }
}

private class Counter: ObservableObject {
    private var timer: Timer?

    @Published var value: Int = 0
    
    init(interval: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in self.value += 1 }
    }
}


struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
