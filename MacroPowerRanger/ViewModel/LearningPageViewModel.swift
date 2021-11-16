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
    @Published var stepByStepIndex: Int = 0
    
    @Published var idleScene = SCNScene(named: "A dan B.usdz")!
    @Published var nodesWithAnimation = [SCNNode()]
    
    @Published var speed: animationSpeed = .normal
    @Published var autoPlayOn: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    

    
    enum animationSpeed: Double {
        case slow = 0.5
        case normal = 1
        case fast = 2
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
        materialIndex = 0
        stepByStepIndex = 0
        autoPlayOn = false
        speed = .normal
    }
    
    func fetchCourseMaterials(course: Course){
        courseMaterials = course.courseMaterials
    }
    
    func getStartFrame() -> Int {
        return courseMaterials[materialIndex].animationsFrame[stepByStepIndex].startFrame
    }
    
    func getEndFrame() -> Int {
        return courseMaterials[materialIndex].animationsFrame[stepByStepIndex].endFrame
    }
    
    func getAnimationKey() -> String {
        return courseMaterials[materialIndex].animationsFrame[stepByStepIndex].animationKey
    }
    
    func playAnimations() {
        for node in nodesWithAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let animPlayer: SCNAnimationPlayer = node.animationPlayer(forKey: self.getAnimationKey()) {
                    animPlayer.animation.repeatCount = .greatestFiniteMagnitude
                    animPlayer.animation.isAppliedOnCompletion = true
                    animPlayer.animation.isRemovedOnCompletion = false
                    animPlayer.speed = self.speed.rawValue
                    let event = SCNAnimationEvent(keyTime: 0.95) { animation, object, backward in
                        print("animation ended")
                        //animPlayer.stop()
                        animPlayer.paused = true
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
                for frame in material.animationsFrame {
                    let idleAnim = anims.animation(from: oldPlayer.animation, startingAtFrame: frame.startFrame, endingAtFrame: frame.endFrame)
                    node.addAnimationPlayer(SCNAnimationPlayer(animation: SCNAnimation(caAnimation: idleAnim)), forKey: frame.animationKey)
                    nodesWithAnimation.append(node)
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
