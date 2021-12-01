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
    @Binding var isPresenting: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("MainColor"))
                .opacity(1)
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea(.all)
            VStack {
                Image("Confetti")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
                    .ignoresSafeArea()
                Spacer()
            }
            Image("Hore")
            
            VStack {
                Spacer(minLength: UIScreen.main.bounds.height * 0.57)
                
                ZStack {
                    Rectangle()
                        .cornerRadius(50)
                        .foregroundColor(Color("ChallengeFinishBackground"))
                        .frame(width: UIScreen.main.bounds.width)
                    
                    VStack() {
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Text("Selamat!")
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .foregroundColor(Color("MainColor"))
                            Text("Kamu berhasil menyelesaikan tantangan")
                                .font(.system(size: 14))
                                .foregroundColor(Color("MainColor"))
                                .padding(.bottom)
                            
                            Text("Skor: \(challengePageViewModel.correctAnswerCounter) Benar, \(challengePageViewModel.wrongAnserCounter) Salah")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.vertical, 20)
                                
                            
//                            Text("Apakah ingin mengulang tema ini atau lanjut ke tema berikutnya?")
//                                .multilineTextAlignment(.center)
//                                .lineLimit(2)
//                                .font(.system(size: 16))
                        }.padding(.horizontal, 60)
                        
                        Spacer()
//                        Spacer()
                        
                        HStack(spacing: 50) {
                            Button {
                                isPresenting = false
                                challengePageViewModel.refreshState()
                            } label: {
                                Text("Ulangi")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("MainColor"))
                                    .padding()
                                    .frame(width: 140, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .strokeBorder(lineWidth: 2)
                                            .foregroundColor(Color("MainColor"))
                                    )
                            }
                            Button {
                                showAlert = true
                            } label: {
                                Text("Lanjut Materi")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 140, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(Color("MainColor"))
                                    )
                            }
                            .alert("Tantangan 2 belum tersedia :(", isPresented: $showAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }.frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom)
                        Spacer()
                    }
                    
                }.frame(width: UIScreen.main.bounds.width)
            }
            
            VStack {
                HStack {
                    Button {
                        isPresenting = false
                        challengePageViewModel.dismissChallenge = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .foregroundColor(.black)
                                    .opacity(0.25)
                                    .frame(width: 40, height: 40)
                            )
                    }
                    .padding(25)
                    .padding(.vertical)
                    Spacer()
                }
                
                Spacer()
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }.onAppear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        
    }
}

//struct ChallengeFinishedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeFinishedView(challengePageViewModel: ChallengePageViewModel(), isPresenting: true)
//    }
//}
