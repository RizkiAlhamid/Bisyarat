//
//  CourseListView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 25/10/21.
//

import SwiftUI

struct CourseListView: View {
    @ObservedObject var viewModel = CourseListViewModel()
    
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack{
                    List {
                        ForEach(viewModel.courses, id: \.id){ course in
                            NavigationLink(destination: LearningPageView(learningPageViewModel: LearningPageViewModel.init(course: course))) {
                                CourseCellView(
                                    title: course.title,
                                    description: course.description,
                                    bgImage: course.bgImage
                                )
                            }
                        }
                    }
                }
                .navigationTitle("Belajar")
                .background(Color.black).ignoresSafeArea()
            }
        }
        .navigationBarHidden(true)
        
        
        
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}