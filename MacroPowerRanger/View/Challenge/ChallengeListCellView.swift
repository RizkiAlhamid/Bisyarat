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
    var scoresementara = 1.0
    var body: some View {
        
        
        
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
                        .padding(.top, 10)
                    HStack{
                        //if 0.3...0.59 ~= scoresementara{
                        if 0.3...0.59 ~= getUserProgress(){
                            Image("piala.fill")
                                //.foregroundColor(.yellow)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala")
                                //.foregroundColor(.primary)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala")
                                //.foregroundColor(.primary)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                        }
                        //else if 0.6...0.99 ~= scoresementara{
                        else if 0.6...0.99 ~= getUserProgress(){
                            Image("piala.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                        }
                        //else if scoresementara == 1{
                        else if getUserProgress() == 1{
                            Image("piala.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                        }
                        //else if 0...0.29 ~= scoresementara{
                        else if 0...0.29 ~= getUserProgress(){
                            Image("piala")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                            Image("piala")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.98, height: 20.57)
                        }
                    }.padding(.bottom,10)
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
    func getUserProgress() -> Double {
        return UserDefaults.standard.double(forKey: "Tantangan \(challenge.title)")
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
