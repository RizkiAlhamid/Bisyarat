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
        }
        .onAppear() {
            adjustValue(tutorialCounter: tutorialCounter)
        }
    }
    
    var tutorialView: some View {
        VStack {
            if tutorialCounter >= 5 {
                Spacer()
            }
            HStack {
                VStack {
                    if tutorialCounter >= 5 {
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
                            .fill(.white)
                            .opacity(0.8)
                    )
                    if tutorialCounter < 5 {
                        Text("Tekan dimana saja untuk melanjutkan")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 150)
                    }
                    
                }
                .frame(width: tutorialCounter == 5 ? 250 : 285)
                .padding(.horizontal)
                
                if tutorialCounter == 5 {
                    Text("Lanjut")
                        .foregroundColor(.black)
                        .frame(width: 80, height: 30)
                        .background (
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 12)
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                )
                        )
                        .padding(.trailing, 10)
                        .offset(y: 55)
                } else if tutorialCounter == 2 {
                    Text(buttonSymbol)
                        .foregroundColor(.black)
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .fill(.white)
                                .background(
                                    Circle()
                                        .stroke(lineWidth: 12)
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                        
                                )
                        )
                        .padding(.trailing, 10)
                        .offset(y: -25)
                } else if tutorialCounter == 6 {
                    
                } else {
                    Image(systemName: buttonSymbol)
                        .foregroundColor(.black)
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .fill(.white)
                                .background(
                                    Circle()
                                        .stroke(lineWidth: 12)
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                        
                                )
                        )
                        .padding(.trailing, 10)
                        .offset(y: -25)
                }
                
                
            }
            .offset(y: offsetValue)
        }
    }
    
    func adjustValue(tutorialCounter: Int) {
        if tutorialCounter == 1 {
            featureName = "Fitur Cermin"
            featureDescription = "Mode pantulan agar lebih mudah kamu ikuti gerakannya"
            offsetValue = -57
            buttonSymbol = "person.fill"
        } else if tutorialCounter == 2 {
            featureName = "Fitur Kecepatan"
            featureDescription = "Sesuaikan kecepatan gerakan 0.5x, 1x, 2x"
            offsetValue = -2
            buttonSymbol = "1x"
        } else if tutorialCounter == 3 {
            featureName = "Fitur Otomatis"
            featureDescription = "Lanjut ke materi berikutnya tanpa menekan layar"
            offsetValue = 55
            buttonSymbol = "play.circle"
        } else if tutorialCounter == 4 {
            featureName = "Fitur Ulangi"
            featureDescription = "Ulangi kembali gerakan yang kamu inginkan"
            offsetValue = 111
            buttonSymbol = "repeat"
        } else if tutorialCounter == 5 {
            featureName = "Langkah - langkah"
            featureDescription = "Tekan tombol lanjut untuk melihat langkah selanjutnya"
            offsetValue = -132
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
