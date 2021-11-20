//
//  CourseSampleData.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct CourseSampleData {
    static var courses: [Course] = [
        Course(id: UUID(), title: "Dasar 1", description: "13 alfabet 3 hari", bgImage: "bgImageDasar1", isFinished: false,
                                           courseMaterials:
                                            [CourseMaterial(id: UUID(), title: "A",
                                                            animFrame: animationFrame(animationKey: "A", startFrame: 0, endFrame: 200)),
                                             
                                             CourseMaterial(id: UUID(), title: "B",
                                                            animFrame: animationFrame(animationKey: "B", startFrame: 301, endFrame: 500)),
                                                             
                                             CourseMaterial(id: UUID(), title: "C"),
                                                             
                                             CourseMaterial(id: UUID(), title: "D"),
                                                             
                                             CourseMaterial(id: UUID(), title: "E"),
                                                             
//                                             CourseMaterial(id: UUID(), title: "F", stepByStepInstructions: ["step 1", "step 2", "step 3"], isFinished: false),
//                                                             
//                                             CourseMaterial(id: UUID(), title: "G", stepByStepInstructions: ["step 1", "step 2", "step 3"], isFinished: false),
//                                                             
//                                             CourseMaterial(id: UUID(), title: "H", stepByStepInstructions: ["step 1", "step 2", "step 3"], isFinished: false),
//                                                             
//                                             CourseMaterial(id: UUID(), title: "I", stepByStepInstructions: ["step 1", "step 2", "step 3"], isFinished: false),
//                                                             
//                                             CourseMaterial(id: UUID(), title: "J", stepByStepInstructions: ["step 1", "step 2", "step 3"], isFinished: false)
                                            ])]
    
    
}
