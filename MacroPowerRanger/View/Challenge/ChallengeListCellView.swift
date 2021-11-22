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
        HStack{
            Image(bgImage)
                .resizable()
                .frame(width: 60, height: 90)
                .scaledToFit()
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
            }
        }
    }
}


