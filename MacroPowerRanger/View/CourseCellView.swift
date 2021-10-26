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
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}
