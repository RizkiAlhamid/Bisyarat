//
//  CourseSampleData.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct CourseSampleData {
    static var courses: [Course] = [Course(id: UUID(), title: "Dasar 1", description: "13 alfabet 3 hari", bgImage: "bgImageDasar1", isFinished: false,
                                           courseMaterials: [CourseMaterial(id: UUID(), title: "A", stepByStepInstructions: ["Astep 1", "Astep 2", "Astep 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "B", stepByStepInstructions: ["Bstep 1", "Bstep 2", "Bstep 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "C", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "D", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "E", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "F", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "G", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "H", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "I", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false),
                                                             CourseMaterial(id: UUID(), title: "J", stepByStepInstructions: ["step 1", "step 2", "step 3"], stepByStepAnimations: ["step 1", "step 2", "step 3"], isFinished: false) ])]
    
    
}
