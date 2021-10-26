//
//  MaterialSnapPicker.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/26/21.
//

import SwiftUI

struct MaterialSnapPicker<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    //properties
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 0, trailingSpace: CGFloat = 0, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    // Offset
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = -2
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color(red: 244/255, green: 244/255, blue: 244/255))
                .frame(maxWidth: .infinity)
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                
                let width = proxy.size.width / 5 - (trailingSpace - spacing)
                let adjustmentWidth = 17.5
                
                HStack(spacing: spacing) {
                    ForEach(list) { item in
                        content(item)
                            .frame(width: proxy.size.width / 5)
                            .offset(x: (CGFloat(currentIndex) * -width) + adjustmentWidth + offset)
                            .gesture(
                                DragGesture()
                                    .updating($offset, body: { value, out, _ in
                                        
                                        out = value.translation.width
                                        
                                    })
                                    .onEnded({ value in
                                        
                                        // Updating current index
                                        let offsetX = value.translation.width
                                        
                                        // convert the translation into progress(0 - 1) and round the value
                                        // based on the progress increasing or decresing the current index
                                        let progress = -offsetX / width
                                        
                                        let roundIndex = progress.rounded()
                                        
                                        // setting min
                                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 3), -2)
                                        
                                        //updating index
                                        currentIndex = index
                                        print(currentIndex, " ", index)
                                    })
                                    .onChanged({ value in
                                        // updating only index
                                        // Updating current index
                                        let offsetX = value.translation.width

                                        // convert the translation into progress(0 - 1) and round the value
                                        // based on the progress increasing or decresing the current index
                                        let progress = -offsetX / width

                                        let roundIndex = progress.rounded()

                                        // setting min
                                        index = max(min(currentIndex + Int(roundIndex), list.count - 3), -2)
                                    })
                            )
//                            .onTapGesture {
//                              currentIndex += 1
//                            }
                    }
                }
                
            }
            .animation(.easeInOut, value: offset == 0)
            
            Circle()
                .strokeBorder(Color(red: 99/255, green: 202/255, blue: 255/255), lineWidth: 5)
                .frame(width: 80, height: 80)
                
        }
    }
}

struct MaterialSnapPicker_Previews: PreviewProvider {
    static var previews: some View {
        LearningPageView(learningPageViewModel: LearningPageViewModel())
    }
}
