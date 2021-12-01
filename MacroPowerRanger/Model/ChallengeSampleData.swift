//
//  PracticeSampleData.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import Foundation
import SwiftUI

struct ChallengeSampleData {
    static var challenges: [Challenge] = [
        Challenge(id: UUID(), title: "Challenge 1", bgImage: "alfabet1Bg",
                  challengeMaterials: [ChallengeMaterial(id: UUID(), title: "A", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "B", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "C", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "D", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "E", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "F", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "I", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "J", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "R", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "S", outlineImage: "outA")
                                    ]),
        Challenge(id: UUID(), title: "Challenge 2", bgImage: "bgImageDasar1",
                  challengeMaterials: [ChallengeMaterial(id: UUID(), title: "A", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "B", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "C", outlineImage: "outA"),
                                    ]),
        Challenge(id: UUID(), title: "Challenge 2", bgImage: "bgImageDasar1",
                  challengeMaterials: [ChallengeMaterial(id: UUID(), title: "A", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "B", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "C", outlineImage: "outA"),
                                    ]),
        Challenge(id: UUID(), title: "Challenge 2", bgImage: "bgImageDasar1",
                  challengeMaterials: [ChallengeMaterial(id: UUID(), title: "A", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "B", outlineImage: "outA"),
                                       ChallengeMaterial(id: UUID(), title: "C", outlineImage: "outA"),
                                    ])
    ]
}
