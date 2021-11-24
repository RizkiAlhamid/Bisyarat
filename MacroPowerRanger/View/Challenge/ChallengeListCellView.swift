//
//  PracticeCellView.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import SwiftUI

struct ChallengeListCellView: View {
    let title: String
    let bgImage: String
    
    var body: some View {
        VStack{
            Text(title)
                
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: 127, height: 20, alignment: .leading)
            
            ZStack{
                Image(bgImage)
                    .resizable()
                    .frame(width: 60, height: 90)
                    .scaledToFit()
            }
            .frame(width: 127, height: 110)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
            )
        }
        .frame(width: 157, height: 181)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray, radius: 3, x: 0, y: 0)

        )

    }
}


