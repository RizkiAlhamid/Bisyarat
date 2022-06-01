//
//  CourseCellView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 25/10/21.
//

import SwiftUI

struct CourseCellView: View {
    @ObservedObject var viewModel = CourseListViewModel()
    var course: Course
    
    let title: String
    let description: String
    let bgImage: String
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        HStack {
            //gambar
            Image(bgImage)
                .resizable()
                .frame(width: 82, height: 118)
                .scaledToFit()
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            //title
                            // badge ceklis
                            Text(title)
                                .font(.system(size: 18))
                                .lineLimit(1)
                                .foregroundColor(.primary)
                            if viewModel.getMaterialFinished(course: course) == course.courseMaterials.count{
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(Color("cellBg"))
                            }
                        }
                        //deskripsi
                        Text(description)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    //tombol next
                    ZStack {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("cellBg"))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.primary)
                    }.padding(.trailing)
                    
                }.padding(.top)
                Spacer()
                
                ProgressBarView(viewModel: viewModel, course: course)
                    .padding(.bottom)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("rowBg"))
                .shadow(color: .init(red: 0, green: 0, blue: 0, opacity: colorScheme == . light ? 0.25 : 0), radius: 5, x: 0, y: 0)
        )
        .padding(.top, 15)
        .padding(.horizontal)
        
    }
    
}

struct ProgressBarView: View {
    @ObservedObject var viewModel = CourseListViewModel()
    var course: Course
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text("\(viewModel.getMaterialFinished(course: course)) dari \(course.courseMaterials.count) materi")
                .font(.system(size: 14))
                .foregroundColor(.primary)
            ZStack(alignment: .leading){
                Capsule().frame(width: 200, height: 5)
                    .foregroundColor(Color.gray)
                
                Capsule().frame(width: 200 * viewModel.getUserProgress(course: course) ,height: 5)
                    .foregroundColor(Color("cellBg"))
            }.frame(height: 10)
        }
    }
}
