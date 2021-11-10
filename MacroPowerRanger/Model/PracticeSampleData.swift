//
//  PracticeSampleData.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import Foundation
import SwiftUI

struct PracticeSampleData {
    static var practices: [Practice] = [
        Practice(id: UUID(), title: "Practice 1", bgImage: "bgImageDasar1", mlModelName: "MLmodel1",
                 practiceMaterials: [PracticeMaterial(id: UUID(), title: "A", outlineImage: "outA"),
                                     PracticeMaterial(id: UUID(), title: "B", outlineImage: "outA"),
                                     PracticeMaterial(id: UUID(), title: "C", outlineImage: "outA"),
                                     PracticeMaterial(id: UUID(), title: "D", outlineImage: "outA"),
                                     PracticeMaterial(id: UUID(), title: "E", outlineImage: "outA")
                                    ])
    ]
}
