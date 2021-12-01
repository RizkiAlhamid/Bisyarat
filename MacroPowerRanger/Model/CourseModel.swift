//
//  CourseModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/21/21.
//

import Foundation

struct Course {
    var id: UUID
    var title: String
    var description: String
    var bgImage: String
    var isFinished: Bool
    var courseMaterials: [CourseMaterial]
}
