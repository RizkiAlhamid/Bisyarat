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
    var animationsFrame: [animationFrame] = [animationFrame(animationKey: "Step1", startFrame: 0, endFrame: 30), animationFrame(animationKey: "Step2", startFrame: 31, endFrame: 65), animationFrame(animationKey: "Step3", startFrame: 66, endFrame: 100)]
    var isFinished: Bool

    
    struct animationFrame {
        var animationKey: String
        var startFrame: Int
        var endFrame: Int
    }
}
