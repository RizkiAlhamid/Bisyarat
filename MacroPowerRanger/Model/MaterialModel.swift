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
    //var stepByStepInstructions: [String]
    var detailedInstruction: String
    var animFrame = animationFrame(animationKey: "Default", startFrame: 290, endFrame: 300)
    var isFinished: Bool = false

}

struct animationFrame {
    var animationKey: String
    var startFrame: Int
    var endFrame: Int
}
