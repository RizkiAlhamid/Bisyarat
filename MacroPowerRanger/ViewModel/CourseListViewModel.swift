//
//  CourseListViewModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 22/10/21.
//

import Foundation
import SwiftUI

class CourseListViewModel: ObservableObject
{
    @Published var courses = [Course]()
    
    init(){
        fetchCourses()
    }
    
    func fetchCourses(){
        courses = CourseSampleData.courses
    }
    
    func getUserProgress() -> Int {
        var materialFinished = 0
        
        for course in courses {
            for material in course.courseMaterials {
                if UserDefaults.standard.bool(forKey: material.title) == true {
                    materialFinished += 1
                }
            }
        }
        
        return materialFinished
    }
}
