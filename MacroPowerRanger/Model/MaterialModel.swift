//
//  MaterialModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct CourseMaterial: Identifiable {
    var id: UUID
    var title: String
    var stepByStepInstructions: [String]
    var animationsFrame: [animationFrame] = [animationFrame(animationKey: "Step1", startFrame: 0, endFrame: 25), animationFrame(animationKey: "Step2", startFrame: 25, endFrame: 60), animationFrame(animationKey: "Step3", startFrame: 60, endFrame: 200)]
    var isFinished: Bool

    
    struct animationFrame {
        var animationKey: String
        var startFrame: Int
        var endFrame: Int
    }
}
