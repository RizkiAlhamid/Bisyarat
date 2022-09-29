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
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        HStack {
            //gambar
            Image(course.bgImage)
                .resizable()
                .frame(width: 86, height: 80)
                .scaledToFit()
                .padding(.vertical, 24)
                .padding(.leading)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            //title
                            Text(course.title)
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                                .lineLimit(1)
                                .foregroundColor(.primary)
                            
                            // badge ceklis
                            //                            if viewModel.getMaterialFinished(course: course) == course.courseMaterials.count{
                            //                                Image(systemName: "checkmark.seal.fill")
                            //                                    .foregroundColor(Color("cellBg"))
                            //                            }
                        }
                        
                        //deskripsi
                        Text(course.description)
                            .fontWeight(.light)
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
                            .foregroundColor(.white)
                    }//.padding(.trailing)
                    
                }//.padding(.top)
                
                Spacer()
                
                ProgressBarView(viewModel: viewModel, course: course)
                // .padding(.bottom)
            }
            .padding(.trailing)
            .padding(.vertical, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("rowBg"))
                .shadow(color: .init(red: 0, green: 0, blue: 0, opacity: colorScheme == . light ? 0.25 : 0), radius: 5, x: 0, y: 0)
        )
        .blur(radius: course.isUnlocked ? 0 : 1)
        .overlay(
            lockedCourseView
                .animation(.default)
        )
        .frame(maxHeight: 128)
        .padding(.vertical, 7.5)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var lockedCourseView: some View {
        if !course.isUnlocked {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0, green: 0, blue: 0))
                    .opacity(0.28)
                HStack {
                    Image(systemName: "lock")
                    Text("Selesaikan materi sebelumnya")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 14))
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                )
            }
        } else {
            EmptyView()
        }
    }
    
}

struct ProgressBarView: View {
    @ObservedObject var viewModel = CourseListViewModel()
    var course: Course
    
    var body: some View{
        VStack(alignment: .leading, spacing: 2){
            Text("\(viewModel.getMaterialFinished(course: course)) dari \(course.courseMaterials.count) materi")
                .fontWeight(.light)
                .font(.system(size: 14))
                .foregroundColor(.primary)
            ZStack(alignment: .leading){
                GeometryReader { (geometry) in
                    Capsule().frame(width: geometry.size.width, height: 5)
                        .foregroundColor(Color.gray)
                    Capsule().frame(width: geometry.size.width * viewModel.getUserProgress(course: course) ,height: 5)
                        .foregroundColor(Color("cellBg"))
                }
            }.frame(height: 10)
        }
    }
}

struct CourseCellView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCellView(course: Course(id: UUID(), title: "Hari", description: "Estimasi 2 hari", bgImage: "bgAlfabet1", isFinished: false, courseMaterials: [], isUnlocked: false))
        CourseCellView(course: CourseSampleData.courses[0])
    }
}
