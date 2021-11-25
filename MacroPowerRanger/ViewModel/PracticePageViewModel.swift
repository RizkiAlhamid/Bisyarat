//
//  PracticePageViewModel.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/25/21.
//

import Foundation


class PracticePageViewModel: ObservableObject {
    @Published var materialPractice = MaterialPractice()
    
    @Published var isGuessedTrue = false
    @Published var isShowingOutline = false
    
    init() {
        fetchCourseMaterials(courseMaterial: CourseSampleData.courses[0].courseMaterials[0])
    }
    
    init(courseMaterial: CourseMaterial) {
        fetchCourseMaterials(courseMaterial: courseMaterial)
    }
    
    func fetchCourseMaterials(courseMaterial: CourseMaterial) {
        materialPractice.title = courseMaterial.title
        materialPractice.outlineImage = courseMaterial.title
    }
    
    func refreshState() {
        isGuessedTrue = false
        isShowingOutline = false
    }
}
