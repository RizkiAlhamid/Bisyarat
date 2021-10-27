//
//  LearningPageViewModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 22/10/21.
//

import Foundation

class LearningPageViewModel: ObservableObject{
    @Published var courseMaterials = [CourseMaterial]()
    @Published var materialIndex: Int = 0
    @Published var stepByStepIndex: Int = 0
    
    var courseTitle: String = ""
    
    init(){
        fetchCourseMaterials(course: CourseSampleData.courses[0])
    }
    
    init(course: Course) {
        fetchCourseMaterials(course: course)
        courseTitle = course.title
    }
    
    func fetchCourseMaterials(course: Course){
        courseMaterials = course.courseMaterials
    }
}
