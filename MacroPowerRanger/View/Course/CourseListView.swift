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
        ZStack{
            VStack(){
                ScrollView() {
                    ForEach(viewModel.courses, id: \.id){ course in
                        NavigationLink(destination: LearningPageView(learningPageViewModel: LearningPageViewModel.init(course: course))) {
                            CourseCellView(
                                viewModel: viewModel, course: course,
                                title: course.title,
                                description: course.description,
                                bgImage: course.bgImage
                            )
                        }
                    }
                    .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                }
            }
            .navigationBarTitleDisplayMode(.large)
        }
    
        
        .onAppear {
            viewModel.updateView()
        }
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
