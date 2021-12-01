//
//  LearningPage.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/17/21.
//

import SwiftUI
import SceneKit

struct LearningPageView: View {
    @AppStorage("showButtonTutorial") var showButtonTutorial: Bool = true
    @ObservedObject var learningPageViewModel: LearningPageViewModel = LearningPageViewModel()
    
    @State var currentIndex: Int = -2
    @State var tutorialCounter: Int = 0
    
    @State var isPaused = false
    @State var shouldShowChatBox = false
    @State var isAnimationEnded = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 15)
                ChatBoxView(vm: learningPageViewModel, shouldShowChatBox: $shouldShowChatBox)
                ZStack {
                    SceneView(scene: learningPageViewModel.loadAnimations(),
                              pointOfView: setUpCamera(),
                              options: [.autoenablesDefaultLighting]
                    )
                    HStack {
                        Spacer()
                        SettingButtonsView(vm: learningPageViewModel, isPaused: $isPaused, shouldShowChatBox: $shouldShowChatBox, isAnimationEnded: $isAnimationEnded)
                    }
                }//.frame(height: UIScreen.main.bounds.height * 0.5)
                
                MaterialSnapPicker(vm: learningPageViewModel, index: $currentIndex, items: learningPageViewModel.courseMaterials) { material in
                    
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        
                        ZStack {
                            Circle()
                                .fill(Color("SecondarySliderColor"))
                                .frame(width: proxy.size.width * 0.45)
                                .clipped()
                            Text(material.title)
                                .font(.system(size: 12))
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                
                        }
                        .scaleEffect(.init(width: scale, height: scale))
                    }.frame(width: 77.5)
                    
                }.frame(height: 125)
                .disabled(tutorialCounter == 6)
                
                
                
                
            }
            .navigationTitle(learningPageViewModel.courseTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    tutorialCounter = 1
                } label: {
                    Text("Info")
                }
            })
            .onChange(of: learningPageViewModel.materialIndex, perform: { newValue in
                isPaused = false
                isAnimationEnded = false
                if learningPageViewModel.autoPlayOn == false {
                    learningPageViewModel.playAnimations(shouldShowChatBox: $shouldShowChatBox, isAnimationEnded: $isAnimationEnded)
                }
            })
            .onAppear {
                learningPageViewModel.refreshState()
                learningPageViewModel.playAnimations(shouldShowChatBox: $shouldShowChatBox, isAnimationEnded: $isAnimationEnded)
                if showButtonTutorial == true {
                    tutorialCounter = 1
                    showButtonTutorial.toggle()
                }
            }
            if tutorialCounter <= 6 && tutorialCounter > 0 {
                LPTutorialView(tutorialCounter: $tutorialCounter)
            }
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).midX
        
        let diff = abs(x - UIScreen.main.bounds.width / 2 - 17.5)
        
        if diff < UIScreen.main.bounds.width - 175 {
            scale = 1 + (UIScreen.main.bounds.width - 200 - diff) / 170
        }
        print("scale", scale)
        return min(scale, 2.09)
    }
    
    static func makeScene() -> SCNScene? {
        let scene = SCNScene(named: "helicopter.scn")
        return scene
    }
    
    
    func setUpCamera() -> SCNNode? {
        let cameraNode = learningPageViewModel.idleScene.rootNode.childNode(withName: "camera", recursively: false)
        return cameraNode
    }
    
}



struct LearningPageView_Previews: PreviewProvider {
    static var previews: some View {
        LearningPageView(learningPageViewModel: LearningPageViewModel())
    }
}

struct ChatBoxView: View {
    @ObservedObject var vm: LearningPageViewModel
    @Binding var shouldShowChatBox: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("SecondaryColor"))
                .frame(height: 110)
                .padding(.horizontal, 25)
            
            Text(vm.courseMaterials[vm.materialIndex].detailedInstruction)
                .multilineTextAlignment(.center)
                .frame(width: 260, height: 100)
        } .opacity(shouldShowChatBox ? 1 : 0)
        
    }
}

struct SettingButtonsView: View {
    @ObservedObject var vm: LearningPageViewModel
    @Binding var isPaused: Bool
    @Binding var shouldShowChatBox: Bool
    @Binding var isAnimationEnded: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink(destination: PracticeView(practicePageViewModel: PracticePageViewModel.init(courseMaterial: vm.courseMaterials[vm.materialIndex]))) {
                Image("PracticeIcon")
                    .frame(width: 41, height: 41)
                    .background(
                        Circle()
                            .strokeBorder(lineWidth: 3)
                            .foregroundColor(Color("MainColor"))
                            .background(
                                Circle()
                                    .fill(Color(red: 169/255, green: 169/255, blue: 169/255, opacity: 0.1))
                            )
                    )
            }.disabled(vm.courseTitle == "Perkenalan Diri")
            
            Button {
                switch vm.speed {
                case .slow:
                    vm.speed = .normal
                case .normal:
                    vm.speed = .slow
                }
                isPaused = false
                if vm.autoPlayOn == false {
                    vm.playAnimations(isAnimationEnded: $isAnimationEnded)
                }
            } label: {
                Image(vm.speed == .slow ? "0.5xSpeedIcon" : "1xSpeedIcon")
                    .frame(width: 41, height: 41)
                    .background(
                        Circle()
                            .strokeBorder(lineWidth: 3)
                            .foregroundColor(Color("MainColor"))
                            .background(
                                Circle()
                                    .fill(Color(red: 169/255, green: 169/255, blue: 169/255, opacity: 0.1))
                            )
                    )
            }
            
            Button {
                isPaused = false
                vm.autoPlayOn.toggle()
                vm.autoPlayAnimation(shouldShowChatBox: $shouldShowChatBox)
            } label: {
                if vm.autoPlayOn {
                    Image("AutoPlayOnIcon")
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .foregroundColor(Color("MainColor"))
                        )
                } else {
                    Image("AutoPlayOffIcon")
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .strokeBorder(lineWidth: 3)
                                .foregroundColor(Color("MainColor"))
                                .background(
                                    Circle()
                                        .fill(Color(red: 169/255, green: 169/255, blue: 169/255, opacity: 0.1))
                                )
                        )
                }
            }
            
            Button {
                isPaused = false
                if shouldShowChatBox {
                    vm.playAnimations(isAnimationEnded: $isAnimationEnded)
                } else {
                    vm.playAnimations(shouldShowChatBox: $shouldShowChatBox, isAnimationEnded: $isAnimationEnded)
                }
            } label: {
                Image("ReplayIcon")
                    .frame(width: 41, height: 41)
                    .background(
                        Circle()
                            .strokeBorder(lineWidth: 3)
                            .foregroundColor(Color("MainColor"))
                            .background(
                                Circle()
                                    .fill(Color(red: 169/255, green: 169/255, blue: 169/255, opacity: 0.1))
                            )
                    )
            }
            
            Button {
                if isAnimationEnded == false {
                    vm.playPauseAnimations(isPaused: $isPaused)
                }
            } label: {
                if isPaused {
                    Image("PlayIcon")
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .foregroundColor(Color("MainColor"))
                        )
                } else {
                    Image("PauseIcon")
                        .frame(width: 41, height: 41)
                        .background(
                            Circle()
                                .strokeBorder(lineWidth: 3)
                                .foregroundColor(Color("MainColor"))
                                .background(
                                    Circle()
                                        .fill(Color(red: 169/255, green: 169/255, blue: 169/255, opacity: 0.1))
                                )
                        )
                }
            }
            
        }
        .padding()
    }

    
}

struct CustomNavigationView: View {
    
    @Environment(\.presentationMode) var presentation
    var courseTitle: String
    @Binding var tutorialCounter: Int
    
    var body: some View {
        ZStack {
            HStack() {
                Button {
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding()
                        .background (
                            Circle()
                                .foregroundColor(Color(red: 99/255, green: 202/255, blue: 255/255))
                                .frame(width: 40, height: 40)
                        )
                        .padding(.horizontal, 15)
                }
                Spacer()
                Button {
                    tutorialCounter = 1
                } label: {
                    Image(systemName: "info")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding()
                        .background (
                            Circle()
                                .foregroundColor(Color(red: 99/255, green: 202/255, blue: 255/255))
                                .frame(width: 40, height: 40)
                        )
                        .padding(.horizontal, 15)
                }
            }
            HStack {
                Text(courseTitle)
                    .font(.system(size: 30))
                    .padding(.horizontal, 60)
            }
        }
    }
}
