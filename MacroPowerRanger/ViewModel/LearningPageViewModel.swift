//
//  LearningPageViewModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 22/10/21.
//

import Foundation

class LearningPageViewModel: ObservableObject{
    @Published var courseMaterials = [CourseMaterial]()
    
//    init(){
//        fetchCourseMaterials()
//    }
    
    func fetchCourseMaterials(course: Course){
        courseMaterials = course.courseMaterials
    }
}
