//
//  PracticeModel.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/10/21.
//

import Foundation
import SwiftUI

struct Challenge: Identifiable {
    var id: UUID
    var title: String
    var bgImage: String
    var isFinished: Bool = false
    var mlModelName: String = "MLModel"
    var challengeMaterials: [ChallengeMaterial]
    
}
