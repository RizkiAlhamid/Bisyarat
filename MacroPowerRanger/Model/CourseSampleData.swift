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
                                            [CourseMaterial(id: UUID(), title: "A", stepByStepInstructions: ["Bentuk segitiga dengan telunjuk dan ibu jari kedua tangan", "Telapak tangan menghadap depan dan tutup jari lainnya"],
                                                            animationsFrame: [animationFrame(animationKey: "A Step1", startFrame: 0, endFrame: 75),
                                                                             animationFrame(animationKey: "A Step 2", startFrame: 76, endFrame: 200)]),
                                                             
                                             CourseMaterial(id: UUID(), title: "B", stepByStepInstructions: ["Telapak tangan kanan menghadap kedalam, buka jari telunjuk, jari tengah, dan jari manis lalu miringkan ke kiri", "Telapak tangan kiri menghadap keluar dan buka jadi telunjuk", "Dekatkan hingga ketiga ujung jari tangan kanan menyentuh talunjuk kiri"],
                                                           animationsFrame: [animationFrame(animationKey: "B Step1", startFrame: 301, endFrame: 375),
                                                                             animationFrame(animationKey: "B Step2", startFrame: 360, endFrame: 400),
                                                                             animationFrame(animationKey: "B Step3", startFrame: 401, endFrame: 500)]),
                                                             
                                             CourseMaterial(id: UUID(), title: "C", stepByStepInstructions: ["Bentuk setengah lingkaran dengan tangan kanan", "Semua jari melengkung dan telapak tangan menghadap kiri"]),
                                                             
                                             CourseMaterial(id: UUID(), title: "D", stepByStepInstructions: ["Bentuk setengah lingkaran dengan telunjuk dan ibu jari tangan kanan, telapak tangan hadap kiri", "buka jari telunjuk dengan tangan kiri, tutup jari lainnya", "Dekatkan hingga ketiga ujung jari tangan kanan menyentuh telunjuk kiri"]),
                                                             
                                             CourseMaterial(id: UUID(), title: "E", stepByStepInstructions: ["Telapak tangan kanan menghadap kedalam, buka jari telunjuk, jari tengah dan jari manis lalu miringkan ke kiri"]),
                                                             
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
