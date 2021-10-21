//
//  CourseSampleData.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct CourseSampleData {
    static var courses: [Course] = [Course(id: UUID(), title: "Dasar 1", description: "13 alfabet 3 hari", bgImage: "Group 45", isFinished: false,
                                           courseMaterials: [CourseMaterial(id: UUID(), title: "A", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: [false, false, false]),
                                                             CourseMaterial(id: UUID(), title: "B", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: [false, false, false]) ])]
    
    
}
