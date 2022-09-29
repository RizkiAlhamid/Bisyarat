//
//  LPTutorialView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/1/21.
//

import SwiftUI

struct LPTutorialView: View {
    
    @Binding var tutorialCounter: Int
    @State var buttonSymbol: String = ""
    @State var offsetValue: CGFloat = 0
    @State var featureName: String = ""
    @State var featureDescription: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    tutorialCounter += 1
                    adjustValue(tutorialCounter: tutorialCounter)
                }
                .offset(y: tutorialCounter == 6 ? -125 : 0)
            if tutorialCounter == 6 {
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color(red: 244/255, green: 244/255, blue: 244/255))
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .cornerRadius(40)
                        .ignoresSafeArea()
                        .opacity(0)
                }
            }
            tutorialView
            
            //skip button
            HStack {
                Spacer()
                VStack {
                    Button {
                        tutorialCounter = 0
                    } label: {
                        Text("Lewati")
                            .foregroundColor(.primary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 244/255, green: 244/255, blue: 244/255))
                            )
                            .padding()
                    }

                    Spacer()
                }
            }
        }
        .onAppear() {
            adjustValue(tutorialCounter: tutorialCounter)
        }
    }
    
    var tutorialView: some View {
        VStack {
            if tutorialCounter > 5 {
                Spacer()
            }
            HStack {
                Spacer()
                
                VStack {
                    if tutorialCounter > 5 {
                        Text("Tekan dimana saja untuk melanjutkan")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 150)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text(featureName)
                            .font(.title2)
                        Text(featureDescription)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("TutorialTextBg"))
                            .opacity(0.8)
                    )
                    if tutorialCounter <= 5 {
                        Text("Tekan dimana saja untuk melanjutkan")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 150)
                    }
                    
                }
                .frame(maxWidth: tutorialCounter == 6 ? 250 : 285)
                .padding(.horizontal)

                Spacer()
                
                if tutorialCounter == 6 {
                    
                } else {
                    Image(buttonSymbol)
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .fill(Color("TutorialIconBg"))
                                .background(
                                    Circle()
                                        .stroke(lineWidth: 16)
                                        .foregroundColor(Color("TutorialIconBgRing"))
                                        .opacity(0.5)
                                    
                                )
                        )
                        .padding(.trailing, 15)
                        .offset(y: -25)
                }
                
                
            }
            .offset(y: offsetValue)
        }
    }
    
    func adjustValue(tutorialCounter: Int) {
        if tutorialCounter == 1 {
            featureName = "Fitur Latihan"
            featureDescription = "Latih langsung materi yang kamu sudah pelajari"
            offsetValue = -87
            buttonSymbol = "PracticeIconTutorial"
        } else if tutorialCounter == 2 {
            featureName = "Fitur Kecepatan"
            featureDescription = "Sesuaikan kecepatan gerakan 1x atau 0.5x"
            offsetValue = -32
            buttonSymbol = "1xSpeedIconTutorial"
        } else if tutorialCounter == 3 {
            featureName = "Fitur Otomatis"
            featureDescription = "Lanjut ke materi berikutnya tanpa menekan layar"
            offsetValue = 25
            buttonSymbol = "AutoPlayIconTutorial"
        } else if tutorialCounter == 4 {
            featureName = "Fitur Ulangi"
            featureDescription = "Ulangi kembali gerakan yang kamu inginkan"
            offsetValue = 81
            buttonSymbol = "ReplayIconTutorial"
        } else if tutorialCounter == 5 {
            featureName = "Fitur Jeda"
            featureDescription = "Tekan tombol untuk menghentikan gerakan animasi"
            offsetValue = 137
            buttonSymbol = "PauseIconTutorial"
        } else if tutorialCounter == 6 {
            featureName = "Geser Materi"
            featureDescription = "Geser ke kiri atau kanan untuk memilih materi"
            offsetValue = -140
        }
    }
}

struct LPTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        LearningPageView(learningPageViewModel: LearningPageViewModel())
    }
}
