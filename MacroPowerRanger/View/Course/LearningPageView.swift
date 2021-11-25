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
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 15)
                ChatBoxView(vm: learningPageViewModel)
                ZStack {
                    SceneView(scene: learningPageViewModel.loadAnimations(),
                              pointOfView: setUpCamera(),
                              options: [.autoenablesDefaultLighting]
                    )
                    HStack {
                        Spacer()
                        SettingButtonsView(vm: learningPageViewModel)
                    }
//                    VStack {
//                        Spacer()
////                        PrevNextButtonView(vm: learningPageViewModel)
////                            .opacity(learningPageViewModel.autoPlayOn ? 0 : 1)
//                    }
                }
                
                MaterialSnapPicker(vm: learningPageViewModel, index: $currentIndex, items: learningPageViewModel.courseMaterials) { material in
                    
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        
                        ZStack {
                            Circle()
                                .fill(Color(red: 176/255, green: 228/255, blue: 255/255, opacity: 0.5))
                                .frame(width: 35)
                                .clipped()
                            Text(material.title)
                                .padding()
                        }
                        .scaleEffect(.init(width: scale, height: scale))
                    }
                    
                }.frame(height: 125)
                
                
                
                
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
            
            .onAppear {
                //learningPageViewModel.fetchCourseMaterials(course: CourseSampleData.courses[0])
                learningPageViewModel.refreshState()
                learningPageViewModel.playAnimations()
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
        
        return scale
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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(red: 210/255, green: 236/255, blue: 249/255))
                .frame(height: 110)
                //.padding(.vertical)
                .padding(.horizontal, 55)
            
            Text(vm.courseMaterials[vm.materialIndex].detailedInstruction)
                .multilineTextAlignment(.center)
                .frame(width: 260, height: 100)
        } .opacity(vm.shouldShowChatBox ? 1 : 0)
        
    }
}

struct SettingButtonsView: View {
    @ObservedObject var vm: LearningPageViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink(destination: PracticeView(practicePageViewModel: PracticePageViewModel.init(courseMaterial: vm.courseMaterials[vm.materialIndex]))) {
                Image(systemName: "hand.wave.fill")
                    .foregroundColor(Color("MainColor"))
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
                switch vm.speed {
                case .slow:
                    vm.speed = .normal
                case .normal:
                    vm.speed = .slow
                }
                vm.playAnimations()
            } label: {
                Text(vm.speed == .slow ? "0.5x" : "\(Int(vm.speed.rawValue))x")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color("MainColor"))
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
                vm.autoPlayOn.toggle()
                vm.autoPlayAnimation()
            } label: {
                Image("Auto Play Icon")
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
                vm.playAnimations()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(Color("MainColor"))
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
                vm.playPauseAnimations()
            } label: {
                Image(systemName: "pause")
                    .foregroundColor(Color("MainColor"))
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
        .padding()
    }
    
//    func autoPlayAnimation() {
//        for node in vm.nodesWithAnimation {
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: vm.getAnimationKey()) {
//                    animPlayer.animation.repeatCount = .greatestFiniteMagnitude
//                    animPlayer.animation.isAppliedOnCompletion = true
//                    animPlayer.animation.isRemovedOnCompletion = false
//                    animPlayer.speed = vm.speed.rawValue
//                    let event = SCNAnimationEvent(keyTime: 0.95) { animation, object, backward in
//                        print("animation ended")
//                        //animPlayer.stop()
//                        animPlayer.paused = true
//                        if vm.autoPlayOn == true {
//                            if vm.stepByStepIndex < vm.courseMaterials[vm.materialIndex].stepByStepInstructions.endIndex - 1 {
//                                DispatchQueue.main.async {
//                                    vm.stepByStepIndex += 1
//                                }
//
//                            }
//                            if vm.stepByStepIndex == vm.courseMaterials[vm.materialIndex].stepByStepInstructions.endIndex - 1 {
//                                DispatchQueue.main.async {
//                                    vm.autoPlayOn = false
//                                }
//                            }
//                            autoPlayAnimation()
//                        }
//                    }
//                    animPlayer.animation.animationEvents = [event]
//                    if vm.autoPlayOn == true {
//                        animPlayer.play()
//                    }
//
//                }
//            }
//        }
//
//
//    }
    
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




//struct PrevNextButtonView: View {
//
//    @ObservedObject var vm: LearningPageViewModel
//
//    var body: some View {
//        HStack {
//            if vm.stepByStepIndex > 0 {
//                Button {
//                    vm.stopAnimations()
//                    vm.stepByStepIndex -= 1
//                    vm.playAnimations()
//                } label: {
//                    Text("Kembali")
//                        .foregroundColor(Color.primary)
//                        .padding()
//                        .background (
//                            RoundedRectangle(cornerRadius: 10)
//                                //.fill(Color(red: 99/255, green: 202/255, blue: 255/255))
//                                .fill(Color("MainColor"))
//                                .frame(width: 80, height: 30)
//                        )
//                        .padding(.horizontal)
//                }
//            }
//
//            Spacer()
//
//            if vm.stepByStepIndex < vm.courseMaterials[vm.materialIndex].stepByStepInstructions.count - 1 {
//                Button {
//                    vm.stopAnimations()
//                    vm.stepByStepIndex += 1
//                    vm.playAnimations()
//                } label: {
//                    Text("Lanjut")
//                        .foregroundColor(Color.primary)
//                        .padding()
//                        .background (
//                            RoundedRectangle(cornerRadius: 10)
//                                //.fill(Color(red: 99/255, green: 202/255, blue: 255/255))
//                                .fill(Color("MainColor"))
//                                .frame(width: 80, height: 30)
//                        )
//                        .padding(.horizontal)
//                }
//            }
//        }
//    }
//}
