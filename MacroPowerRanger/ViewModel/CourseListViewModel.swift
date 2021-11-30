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
    @Published private var refresh = false
    
    init(){
        fetchCourses()
    }
    
    func fetchCourses(){
        courses = CourseSampleData.courses
    }
    
    
    
    func getUserProgress(course: Course) -> Double {
        var materialFinished = 0.0
        var totalMaterial = 0.0
        
            for material in course.courseMaterials {
                if UserDefaults.standard.bool(forKey: material.title) == true {
                    materialFinished += 1
                }
                totalMaterial += 1
            }
        
        return materialFinished/totalMaterial
    }
    
    func getMaterialFinished(course: Course) -> Int {
        var materialFinished = 0
        
            for material in course.courseMaterials {
                if UserDefaults.standard.bool(forKey: material.title) == true {
                    materialFinished += 1
                }
            }
        
        return materialFinished
    }

    
    func updateView() {
        refresh.toggle()
    }
}
