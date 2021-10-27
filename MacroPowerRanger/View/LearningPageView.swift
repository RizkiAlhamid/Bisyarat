//
//  LearningPage.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/17/21.
//

import SwiftUI
import SceneKit

struct LearningPageView: View {
    
    @ObservedObject var learningPageViewModel: LearningPageViewModel = LearningPageViewModel()
    
    @State var currentIndex: Int = -2
    
    var scene = makeScene()
    
    var body: some View {
        VStack {
            CustomNavigationView(courseTitle: learningPageViewModel.courseTitle)
            ChatBoxView(vm: learningPageViewModel)
            ZStack {
//                Ellipse()
//                    .foregroundColor(Color(red: 161/255, green: 159/255, blue: 137/255))
//                    .padding()
                SceneView(scene: scene,
                          pointOfView: setUpCamera(),
                          options: []
                )
                HStack {
                    Spacer()
                    SettingButtonsView()
                }
                VStack {
                    Spacer()
                    Button("Play/Stop") {
                        scene?.isPaused.toggle()
                    }
                    PrevNextButtonView(vm: learningPageViewModel)
                }
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
        .navigationBarHidden(true)
        .onAppear {
            //learningPageViewModel.fetchCourseMaterials(course: CourseSampleData.courses[0])
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
      let cameraNode = scene?.rootNode.childNode(withName: "camera", recursively: false)
      return cameraNode
    }
    
}



struct LearningPageView_Previews: PreviewProvider {
    static var previews: some View {
        LearningPageView(learningPageViewModel: LearningPageViewModel())
    }
}

struct CustomNavigationView: View {
    
    @Environment(\.presentationMode) var presentation
    var courseTitle: String
    
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
            }
            HStack {
                Text(courseTitle)
                    .font(.system(size: 30))
                    .padding(.horizontal, 60)
            }
        }
    }
}

struct ChatBoxView: View {
    @ObservedObject var vm: LearningPageViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(red: 248/255, green: 193/255, blue: 154/255))
                .frame(height: 80)
                .padding(.vertical)
                .padding(.horizontal, 55)
            
            Text(vm.courseMaterials[vm.materialIndex].stepByStepInstructions[vm.stepByStepIndex])
                .multilineTextAlignment(.center)
                .frame(width: 260, height: 80)
        }
        
    }
}

struct SettingButtonsView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.fill")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
            Image(systemName: "timer")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
            Image(systemName: "play.circle")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
            Image(systemName: "repeat")
                .frame(width: 41, height: 41)
                .background(
                    Circle()
                        .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                )
        }
        .padding()
    }
}

struct PrevNextButtonView: View {
    
    @ObservedObject var vm: LearningPageViewModel
    
    var body: some View {
        HStack {
            if vm.stepByStepIndex > 0 {
                Button {
                    vm.stepByStepIndex -= 1
                } label: {
                    Text("Prev")
                        .foregroundColor(.black)
                        .padding()
                        .background (
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                                .frame(width: 60, height: 30)
                        )
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            if vm.stepByStepIndex < vm.courseMaterials[vm.materialIndex].stepByStepInstructions.count - 1 {
                Button {
                    vm.stepByStepIndex += 1
                } label: {
                    Text("Next")
                        .foregroundColor(.black)
                        .padding()
                        .background (
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 99/255, green: 202/255, blue: 255/255))
                                .frame(width: 60, height: 30)
                        )
                        .padding(.horizontal)
                }
            }
        }
    }
}
