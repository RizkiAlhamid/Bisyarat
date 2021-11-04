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
                                            [CourseMaterial(id: UUID(), title: "A", stepByStepInstructions: ["Bentuk segitiga dengan telunjuk dan ibu jari kedua tangan", "Telapak tangan menghadap depan dan tutup jari lainnya"], isFinished: false),
                                                             
                                             CourseMaterial(id: UUID(), title: "B", stepByStepInstructions: ["Telapak tangan kanan menghadap kedalam, buka jari telunjuk, jari tengah, dan jari manis lalu miringkan ke kiri", "Telapak tangan kiri menghadap keluar dan buka jadi telunjuk", "Dekatkan hingga ketiga ujung jari tangan kanan menyentuh talunjuk kiri"], isFinished: false),
                                                             
                                             CourseMaterial(id: UUID(), title: "C", stepByStepInstructions: ["Bentuk setengah lingkaran dengan tangan kanan", "semua jari melengkung dan telapak tangan menghadap kiri"], isFinished: false),
                                                             
                                             CourseMaterial(id: UUID(), title: "D", stepByStepInstructions: ["bentuk setengah lingkaran dengan telunjuk dan ibu jari tangan kanan, telapak tangan hadap kiri", "buka jari telunjuk dengan tangan kiri, tutup jari lainnya", "dekatkan hingga ketiga ujung jari tangan kanan menyentuh telunjuk kiri"], isFinished: false),
                                                             
                                             CourseMaterial(id: UUID(), title: "E", stepByStepInstructions: ["telapak tangan kanan menghadap kedalam, buka jari telunjuk, jari tengah dan jari manis lalu miringkan ke kiri"], isFinished: false),
                                                             
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
