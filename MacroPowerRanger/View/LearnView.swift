//
//  LearnView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 18/10/21.
//

import SwiftUI

struct LearnBannerView: View{
    var body: some View{
        VStack{
            TabView{
                LearnView(systemImageName: "scribble.variable")
                LearnView(systemImageName: "paintpalette.fill")
                LearnView(systemImageName: "dial.min.fill")
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .ignoresSafeArea()
            Spacer()
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(maxWidth:.infinity)
                    .frame(height: UIScreen.main.bounds.height/1.5)
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: -4)
                    .ignoresSafeArea()
                
                
                HStack{
                    Image(systemName: "graduationcap.fill")
                        .frame(width: 90, height: 150)
                    VStack(alignment: .leading){
                        Text("Dasar 1")
                        Text("13 Alfabet 2 hari")
                    }
                    
                    Image(systemName: "timelapse")
                        .frame(width: 90, height: 60)
                }
                
                .background(Color.ui.MainColor)
                .cornerRadius(30)
                .border(Color.ui.SecColor, width: 12)
                .cornerRadius(30)
                .frame(width: 400, height: 300)
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 4)
                
            }
        }
        .background(Color.ui.MainColor)
        .ignoresSafeArea()
    }
}

struct LearnBannerView_Previews: PreviewProvider{
    static var previews: some View{
        LearnBannerView()
    }
}

struct LearnView: View {
    let systemImageName: String
    
    var body: some View {
        
        
        VStack(spacing: 20){
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let MainColor = Color("MainColor")
        let SecColor = Color("SetColor")
    }
}
