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
    var stepByStepAnimations: [String]
    var isFinished: Bool
    
}
