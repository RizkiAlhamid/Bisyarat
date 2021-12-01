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
    var challenge: Challenge
    
    var body: some View {
        
        //Belum nemu cara
        
        VStack(alignment: .leading, spacing: 0){
            //title
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.primary)
                .padding(.top)
                .padding(.horizontal)
                
            //image
            Image(bgImage)
                .resizable()
                .frame(width: 159, height: 77)
                .aspectRatio(contentMode: .fit)
                .listRowInsets(EdgeInsets())
            
            ZStack{
                //box bawah
                    Color("challengeBg")
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                VStack{
                    HStack{
                        Image(systemName: "flag.and.flag.filled.crossed")
                        Text("\(challenge.challengeMaterials.count) Alfabet")
                    }.foregroundColor(.black)
                        .padding(.bottom, 10)
                    HStack{
                        Image(systemName: "crown.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "crown")
                            .foregroundColor(.primary)
                        Image(systemName: "crown")
                            .foregroundColor(.primary)
                    }
                }
                
            }.frame(width: 160, height: 69)
                
        }
//        VStack{
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.black)
//                .frame(width: 127, height: 20, alignment: .leading)
//
//            VStack{
//                Image(bgImage)
//                    .resizable()
//                    .frame(width: 60, height: 90)
//                    .scaledToFit()
//                ZStack(alignment: .bottom){
//                    Text("Test")
//                        .foregroundColor(.black)
//                    Color("challengeBg")
//                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
//
//                }.frame(width: 157, height: 69)
//            }
//
//
//        }
        
        .frame(width: 157, height: 181)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray, radius: 5, x: 0, y: 0).opacity(0.5)

        )

    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
