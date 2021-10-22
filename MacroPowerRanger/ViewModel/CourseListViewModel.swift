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
}
