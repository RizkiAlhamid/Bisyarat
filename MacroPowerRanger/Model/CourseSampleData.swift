//
//  CourseSampleData.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct CourseSampleData {
    static var courses: [Course] = [
        Course(id: UUID(), title: "Alfabet 1", description: "5 Materi", bgImage: "bgImageDasar1", isFinished: false,
               courseMaterials:
                [CourseMaterial(id: UUID(), title: "A", detailedInstruction: "Kedua telapak tangan menghadap depan, tutup jari selain ibu dan telunjuk ya",
                                                            animFrame: animationFrame(animationKey: "A", startFrame: 0, endFrame: 100)),
                                             
                 CourseMaterial(id: UUID(), title: "B", detailedInstruction: "Tangan kanan menghadap dalam dan tangan kiri menghadap luar ya",
                                                            animFrame: animationFrame(animationKey: "B", startFrame: 200, endFrame: 280)),
                                                             
                 CourseMaterial(id: UUID(), title: "C", detailedInstruction: "Bentuk huruf C dengan Ibu jari dan telunjuk saja ya",
                                animFrame: animationFrame(animationKey: "C", startFrame: 380, endFrame: 460)),
                                                             
                 CourseMaterial(id: UUID(), title: "D", detailedInstruction: "Tempelkan bentuk C ke bentuk angka 1 ya",
                                animFrame: animationFrame(animationKey: "D", startFrame: 560, endFrame: 640)),
                                                             
                 CourseMaterial(id: UUID(), title: "E", detailedInstruction: "Miringkan hingga  ketiga ujung jari menghadap samping ya",
                                animFrame: animationFrame(animationKey: "E", startFrame: 700, endFrame: 810)),
                ]),
        
        Course(id: UUID(), title: "Alfabet 2", description: "5 Materi", bgImage: "bgImageDasar1", isFinished: false,
               courseMaterials:
                [CourseMaterial(id: UUID(), title: "F", detailedInstruction: "Jari telunjuk dan ibu jari cukup dibuka sedikit saja ya",
                                animFrame: animationFrame(animationKey: "F", startFrame: 850, endFrame: 950)),
                                             
                 CourseMaterial(id: UUID(), title: "I", detailedInstruction: "Ujung jari kelingking menghadap atas ya",
                                animFrame: animationFrame(animationKey: "I", startFrame: 970, endFrame: 1080)),
                     
                 CourseMaterial(id: UUID(), title: "R", detailedInstruction: "Petik ibu jari dan jari tengah ya",
                                animFrame: animationFrame(animationKey: "R", startFrame: 1100, endFrame: 1240)),
                 
                 CourseMaterial(id: UUID(), title: "J", detailedInstruction: "Ayunkan tangan kebawah membentuk kail ya",
                                animFrame: animationFrame(animationKey: "J", startFrame: 1230, endFrame: 1420)),

                 CourseMaterial(id: UUID(), title: "S", detailedInstruction: "Kedua tangan membentuk huruf C dengan tangan kanan diatas ya",
                                animFrame: animationFrame(animationKey: "S", startFrame: 1430, endFrame: 1580)),
                ]),
        
        Course(id: UUID(), title: "Perkenalan Diri", description: "3 Materi", bgImage: "bgImageDasar1", isFinished: false,
               courseMaterials:
                [CourseMaterial(id: UUID(), title: "Halo", detailedInstruction: "Gerakan tanganmu ke kanan dan kiri ya",
                                animFrame: animationFrame(animationKey: "Halo", startFrame: 1600, endFrame: 1740)),
                                             
                 CourseMaterial(id: UUID(), title: "Nama", detailedInstruction: "Letakkan telapak tangan di daerah dada ya",
                                animFrame: animationFrame(animationKey: "Nama", startFrame: 1660, endFrame: 1800)),
                     
                 CourseMaterial(id: UUID(), title: "Saya", detailedInstruction: "",
                                animFrame: animationFrame(animationKey: "Saya", startFrame: 1720, endFrame: 1840)),
                ]),
        
//        Course(id: UUID(), title: "Kata Sapaan", description: "3 Materi", bgImage: "bgImageDasar1", isFinished: false,
//               courseMaterials:
//                []),
        
    
    ]
    
    
}
