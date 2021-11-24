//
//  ChallengeFinishedView.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/24/21.
//

import SwiftUI

struct ChallengeFinishedView: View {
    
    @ObservedObject var challengePageViewModel: ChallengePageViewModel
    @State private var showAlert = false
    
    var body: some View {
        if challengePageViewModel.currentProgress == 1 {
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea(.all)
                Rectangle()
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.6)
                VStack {
                    HStack {
                        Button {
                            challengePageViewModel.dismissChallenge = true
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .opacity(0.25)
                                .frame(width: 40, height: 40)
                        }
                        .padding()
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("🎉")
                            .font(.system(size: 150))
                            .frame(width: 200, height: 200)
                        Text("Selamat!")
                            .font(.system(size: 30))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Jumlah benar: \(challengePageViewModel.correctAnswerCounter)")
                        Text("Jumlah salah: \(challengePageViewModel.wrongAnserCounter)")
                    }
                    .font(.title2)
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    HStack(spacing: 50) {
                        Button {
                            challengePageViewModel.refreshState()
                        } label: {
                            Text("Ulangi")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.gray)
                                )
                        }
                        Button {
                             showAlert = true
                        } label: {
                            Text("Lanjut")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("MainColor"))
                                )
                        }
                        .alert("Tantangan 2 belum tersedia :(", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                    }.padding(.vertical)
                }.frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.6)
            }.onAppear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
        } else {
            EmptyView()
        }
        
    }
}

struct ChallengeFinishedView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeFinishedView(challengePageViewModel: ChallengePageViewModel())
    }
}
