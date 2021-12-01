//
//  LearningPageViewModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 22/10/21.
//

import Foundation
import SceneKit
import SwiftUI

class LearningPageViewModel: ObservableObject{
    @Published var courseMaterials = [CourseMaterial]()
    @Published var materialIndex: Int = 0
    @Published var sliderIndex: Int = -2
    
    @Published var idleScene = SCNScene(named: "Alfabet dan pengenalan diri.usdz")!
    @Published var nodesWithAnimation = [SCNNode()]
    
    @Published var speed: animationSpeed = .normal
    @Published var autoPlayOn: Bool = false
    @Published var shouldShowChatBox = true
    
    @Published var isPaused = false
    
    @Environment(\.colorScheme) var colorScheme
    
    enum animationSpeed: Double {
        case slow = 0.5
        case normal = 1
    }
    
    var courseTitle: String = "Dasar 1"
    
    init(){
        fetchCourseMaterials(course: CourseSampleData.courses[0])

    }
    
    init(course: Course) {
        fetchCourseMaterials(course: course)
        courseTitle = course.title
    }
    
    func refreshState() {
        sliderIndex = -2
        materialIndex = 0
        autoPlayOn = false
        speed = .normal
        shouldShowChatBox = true
    }
    
    func fetchCourseMaterials(course: Course){
        courseMaterials = course.courseMaterials
    }
    
    func getStartFrame() -> Int {
        return courseMaterials[materialIndex].animFrame.startFrame
    }
    
    func getEndFrame() -> Int {
        return courseMaterials[materialIndex].animFrame.endFrame
    }
    
    func getAnimationKey() -> String {
        return courseMaterials[materialIndex].animFrame.animationKey
    }
    
    func playAnimations(isAnimationEnded: Binding<Bool>) {
        isAnimationEnded.wrappedValue = false
        for node in nodesWithAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: self.getAnimationKey()) {
                    animPlayer.animation.repeatCount = 1
                    animPlayer.animation.isAppliedOnCompletion = true
                    animPlayer.animation.isRemovedOnCompletion = false
                    animPlayer.speed = self.speed.rawValue
                    let event = SCNAnimationEvent(keyTime: 0.95) { animation, object, backward in
                        print("animation ended")
                        //animPlayer.stop()
                        animPlayer.paused = true
                        isAnimationEnded.wrappedValue = true
//                        DispatchQueue.main.sync {
//                            self.shouldShowChatBox = true
//                        }
                        //
                        if UserDefaults.standard.bool(forKey: self.courseMaterials[self.materialIndex].title) {
                            print("Data already saved")
                        } else {
                            UserDefaults.standard.set(true, forKey: self.courseMaterials[self.materialIndex].title)
                        }
                    }
                    animPlayer.animation.animationEvents = [event]
                    animPlayer.play()
                }
            }
        }
        
    }
    
    func playAnimations(shouldShowChatBox: Binding<Bool>, isAnimationEnded: Binding<Bool>) {
        shouldShowChatBox.wrappedValue = false
        for node in nodesWithAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: self.getAnimationKey()) {
                    animPlayer.animation.repeatCount = 1
                    animPlayer.animation.isAppliedOnCompletion = true
                    animPlayer.animation.isRemovedOnCompletion = false
                    animPlayer.speed = self.speed.rawValue
                    let event = SCNAnimationEvent(keyTime: 0.95) { animation, object, backward in
                        print("animation ended")
                        shouldShowChatBox.wrappedValue = true
                        //animPlayer.stop()
                        animPlayer.paused = true
                        isAnimationEnded.wrappedValue = true
//                        DispatchQueue.main.sync {
//                            self.isAnimationEnded = true
//                        }
                        //
                        if UserDefaults.standard.bool(forKey: self.courseMaterials[self.materialIndex].title) {
                            print("Data already saved")
                        } else {
                            UserDefaults.standard.set(true, forKey: self.courseMaterials[self.materialIndex].title)
                        }
                    }
                    animPlayer.animation.animationEvents = [event]
                    animPlayer.play()
                }
            }
        }
        
    }
    
    func stopAnimations() {
        autoPlayOn = false
        for node in nodesWithAnimation {
            if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: self.getAnimationKey()) {
                animPlayer.stop()
            }
        }
    }
    
    func playPauseAnimations(isPaused: Binding<Bool>) {
        var counter = 0
        for node in nodesWithAnimation {
            if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: self.getAnimationKey()) {
                animPlayer.paused.toggle()
                isPaused.wrappedValue.toggle()
                counter += 1
                if counter % 2 == 0 {
                    animPlayer.paused.toggle()
                    isPaused.wrappedValue.toggle()
                }
            }
        }
    }
    
    func loadAnimations() -> SCNScene? {
        // This node will be parent of all the animation models
        let node = SCNNode()
        
        // Add all the child nodes to the parent node
        for child in idleScene.rootNode.childNodes {
            if (child.childNodes.count > 0) {
                for item in child.childNodes {
                    for item2 in item.childNodes {
                        if item2.animationKeys.count > 0 {
                            saveAnimationPlayer(node: item2)
                        }
                        for item3 in item2.childNodes {
                            if item3.animationKeys.count > 0 {
                                saveAnimationPlayer(node: item3)
                            }
                            for item4 in item3.childNodes {
                                if item4.animationKeys.count > 0 {
                                    saveAnimationPlayer(node: item4)
                                }
                                for item5 in item4.childNodes {
                                    if item5.animationKeys.count > 0 {
                                        saveAnimationPlayer(node: item5)
                                    }
                                    for item6 in item5.childNodes {
                                        if item6.animationKeys.count > 0 {
                                            saveAnimationPlayer(node: item6)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            node.addChildNode(child)
            
        }
        
        //idleScene.background.contents = (colorScheme == .dark ? UIColor.black : UIColor.white)
        //idleScene.background.contents = UIColor.init(red: 0, green: 0, blue: 0, alpha: colorScheme == .light ? 0.5 : 0.5)
        idleScene.background.contents = UIColor.systemBackground
        
        idleScene.rootNode.addChildNode(node)

        return idleScene
    }
    
    
    func saveAnimationPlayer(node: SCNNode) {
        let animations = node.animationKeys
        
        if let oldPlayer = node.animationPlayer(forKey: animations.first!) {
            // initially stop it
            oldPlayer.stop()
            
            // make an animation for each animation group
            let anims = Animations()
            
            for material in courseMaterials {
                    let idleAnim = anims.animation(from: oldPlayer.animation, startingAtFrame: material.animFrame.startFrame, endingAtFrame: material.animFrame.endFrame)
                    node.addAnimationPlayer(SCNAnimationPlayer(animation: SCNAnimation(caAnimation: idleAnim)), forKey: material.animFrame.animationKey)
                    nodesWithAnimation.append(node)
            }
        }
    }
    
    func autoPlayAnimation(shouldShowChatBox: Binding<Bool>) {
        shouldShowChatBox.wrappedValue = false
        for node in nodesWithAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: self.getAnimationKey()) {
                    animPlayer.animation.repeatCount = .greatestFiniteMagnitude
                    animPlayer.animation.isAppliedOnCompletion = true
                    animPlayer.animation.isRemovedOnCompletion = false
                    animPlayer.speed = self.speed.rawValue
                    let event = SCNAnimationEvent(keyTime: 0.95) { animation, object, backward in
                        print("animation ended")
                        shouldShowChatBox.wrappedValue = true
                        //animPlayer.stop()
                        animPlayer.paused = true
                        
                        if UserDefaults.standard.bool(forKey: self.courseMaterials[self.materialIndex].title) {
                            print("Data already saved")
                        } else {
                            UserDefaults.standard.set(true, forKey: self.courseMaterials[self.materialIndex].title)
                        }
                        
                        if self.autoPlayOn == true {
                            if self.materialIndex < self.courseMaterials.endIndex - 1 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    self.materialIndex += 1
                                    self.sliderIndex += 1
                                }
                                
                            }
                            if self.materialIndex == self.courseMaterials.endIndex - 1 {
                                DispatchQueue.main.async {
                                    self.autoPlayOn = false
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    self.autoPlayAnimation(shouldShowChatBox: shouldShowChatBox)
                                }
                            }
                        }

                    }
                    animPlayer.animation.animationEvents = [event]
                    if self.autoPlayOn == true {
                        animPlayer.play()
                    }
                    
                }
            }
        }
        
        
    }
    
//    func loadAnimations() -> SCNScene? {
//        // Load the character in the idle animation
//        //let idleScene = SCNScene(named: "helicopter.scn")!
//
//        // This node will be parent of all the animation models
//        let node = SCNNode()
//
//        // Add all the child nodes to the parent node
//        for child in idleScene.rootNode.childNodes {
//
//            if (child.childNodes.count > 0) {
//                for item in child.childNodes {
//                    if item.animationKeys.count > 0 {
//                        let animations = item.animationKeys
//
//                        if let oldPlayer = item.animationPlayer(forKey: animations.first!) {
//                            // initially stop it
//                            oldPlayer.stop()
//
//                            // make an animation for each animation group
//                            let anims = Animations()
//                            let idleAnim = anims.animation(from: oldPlayer.animation, startingAtFrame: self.getStartFrame(), endingAtFrame: self.getEndFrame())
//
//                            item.addAnimationPlayer(SCNAnimationPlayer(animation: SCNAnimation(caAnimation: idleAnim)), forKey: "\(self.getAnimationKey())")
//                            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
//                                if let idlePlayer: SCNAnimationPlayer = item.animationPlayer(forKey: "\(self.getAnimationKey())") {
//                                    idlePlayer.animation.repeatCount = CGFloat(Float.greatestFiniteMagnitude)
//                                    idlePlayer.animation.blendInDuration = TimeInterval(CGFloat(1))
//                                    idlePlayer.animation.blendOutDuration = TimeInterval(CGFloat(0.5))
//
//                                    let event = SCNAnimationEvent(keyTime: 1) { animation, object, backward in
//                                        print("animation ended")
//                                        print(NSDate())
//                                        //idlePlayer.stop()
//                                    }
//                                    idlePlayer.animation.animationEvents = [event]
//                                    idlePlayer.play()
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            node.addChildNode(child)
//
//        }
//
////        // Set up some properties
////        node.position = SCNVector3(0, -1, -2)
////        node.eulerAngles.y = 0
////        node.scale = SCNVector3(0.025, 0.025, 0.025)
//
//        // return node
//        idleScene.rootNode.addChildNode(node)
//        return idleScene
//    }
    
    
    
    
}


//let cameraNode = SCNNode()
//cameraNode.camera = SCNCamera()
//cameraNode.position = SCNVector3(0, 0.5, 1.35)
//cameraNode.eulerAngles = SCNVector3(x: -7.222, y: 0.618, z: 0)
//
//idleScene.rootNode.addChildNode(cameraNode)


//
//        let geom = idleScene.rootNode.childNode(withName: "Geom", recursively: true)
//        print(geom)
//        let skeleton = geom?.childNode(withName: "Skeleton", recursively: true)!
//        print(skeleton, skeleton?.animationKeys.count)
