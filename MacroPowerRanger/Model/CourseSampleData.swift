//
//  CourseSampleData.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct CourseSampleData {
    static var courses: [Course] = [
        Course(id: UUID(), title: "Alfabet 1", description: "5 Materi", bgImage: "bgAlfabet1", isFinished: false,
               courseMaterials:
                [CourseMaterial(id: UUID(), title: "A", detailedInstruction: "Ibu jari dan telunjuk kedua tangan membentuk segitiga ya",
                                                            animFrame: animationFrame(animationKey: "A", startFrame: 0, endFrame: 100)),
                                             
                 CourseMaterial(id: UUID(), title: "B", detailedInstruction: "Tangan kanan membentuk angka 3 dan tangan kiri membentuk angka 1 ya",
                                                            animFrame: animationFrame(animationKey: "B", startFrame: 200, endFrame: 280)),
                                                             
                 CourseMaterial(id: UUID(), title: "C", detailedInstruction: "Bentuk huruf C dengan Ibu jari dan telunjuk saja ya",
                                animFrame: animationFrame(animationKey: "C", startFrame: 380, endFrame: 460)),
                                                             
                 CourseMaterial(id: UUID(), title: "D", detailedInstruction: "Tangan kanan membentuk huruf C dan tangan kiri membentuk angka 1 ya",
                                animFrame: animationFrame(animationKey: "D", startFrame: 560, endFrame: 640)),
                                                             
                 CourseMaterial(id: UUID(), title: "E", detailedInstruction: "Tangan kanan membentuk angka 3 lalu di miringkan ke kiri ya",
                                animFrame: animationFrame(animationKey: "E", startFrame: 700, endFrame: 810)),
                ]),
        
        Course(id: UUID(), title: "Alfabet 2", description: "5 Materi", bgImage: "bgAlfabet2", isFinished: false,
               courseMaterials:
                [CourseMaterial(id: UUID(), title: "F", detailedInstruction: "Buka sedikit jari telunjuk dan ibu jari tangan kanan dan tangan kiri membentuk angka satu ya",
                                animFrame: animationFrame(animationKey: "F", startFrame: 850, endFrame: 950)),
                                             
                 CourseMaterial(id: UUID(), title: "I", detailedInstruction: "Tutup semua jari dan buka jari kelingking saja ya",
                                animFrame: animationFrame(animationKey: "I", startFrame: 970, endFrame: 1080)),
                     
                 CourseMaterial(id: UUID(), title: "R", detailedInstruction: "Buka tiga jari teratas lalu petik ibu jari dan jari tengah ya",
                                animFrame: animationFrame(animationKey: "R", startFrame: 1100, endFrame: 1240)),
                 
                 CourseMaterial(id: UUID(), title: "J", detailedInstruction: "Buat bentuk seperti huruf i lalu ayunkan tangan kebawah membentuk kail ya",
                                animFrame: animationFrame(animationKey: "J", startFrame: 1230, endFrame: 1420)),

                 CourseMaterial(id: UUID(), title: "S", detailedInstruction: "Kedua tangan membentuk huruf C dengan tangan kanan diatas ya",
                                animFrame: animationFrame(animationKey: "S", startFrame: 1430, endFrame: 1580)),
                ]),
        
        Course(id: UUID(), title: "Perkenalan Diri", description: "3 Materi", bgImage: "bgPerkenalanDiri", isFinished: false,
               courseMaterials:
                [CourseMaterial(id: UUID(), title: "Halo", detailedInstruction: "Gerakan tanganmu ke kanan dan kiri seperti melambaikan tangan ya",
                                animFrame: animationFrame(animationKey: "Halo", startFrame: 1600, endFrame: 1740)),
                                             
                 CourseMaterial(id: UUID(), title: "Nama", detailedInstruction: "Buka sedikit jari telunjuk dan ibu jari tangan kanan lalu gerakkan secara horizontal di telapak kiri ya",
                                animFrame: animationFrame(animationKey: "Nama", startFrame: 1660, endFrame: 1800)),
                     
                 CourseMaterial(id: UUID(), title: "Saya", detailedInstruction: "Letakkan telapak tangan di daerah dada ya",
                                animFrame: animationFrame(animationKey: "Saya", startFrame: 1720, endFrame: 1840)),
                ]),
        
//        Course(id: UUID(), title: "Kata Sapaan", description: "3 Materi", bgImage: "bgImageDasar1", isFinished: false,
//               courseMaterials:
//                []),
        
    
    ]
    
    
}
