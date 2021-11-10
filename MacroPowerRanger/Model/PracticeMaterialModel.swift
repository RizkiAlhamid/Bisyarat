//
//  PracticeMaterialModel.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/10/21.
//

import Foundation
import SwiftUI

struct PracticeMaterial: Identifiable {
    var id: UUID
    var title: String
    var outlineImage: String
    var isFinished: Bool = false
}
