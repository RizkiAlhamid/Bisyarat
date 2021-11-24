//
//  CourseCellView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 25/10/21.
//

import SwiftUI

struct CourseCellView: View {
    
    let title: String
    let description: String
    let bgImage: String
    
    
    var body: some View {
        HStack{
            Image(bgImage)
                .resizable()
                .frame(width: 60, height: 90)
                .scaledToFit()
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .scaledToFit()
                Spacer()
                ProgressBarView()
            }.frame(width: 150)
            Spacer()
            ZStack{
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
            
        }
        
    }
}

struct ProgressBarView: View {
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            Text("13 dari 13 materi")
                .font(.system(size: 14))
                .foregroundColor(.black)
            ZStack{
                Capsule().frame(width: 120)
                    .foregroundColor(Color.gray)
                
                Capsule().frame(width: 120)
                    .foregroundColor(Color.blue)
            }.frame(height: 10)
        }
    }
}
