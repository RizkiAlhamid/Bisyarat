//
//  MaterialSnapPicker.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 10/26/21.
//

import SwiftUI

struct MaterialSnapPicker<Content: View>: View {
    @ObservedObject var vm: LearningPageViewModel
    var content: (CourseMaterial) -> Content
    var list: [CourseMaterial]
    
    //properties
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(vm: LearningPageViewModel, spacing: CGFloat = 0, trailingSpace: CGFloat = 0, index: Binding<Int>, items: [CourseMaterial], @ViewBuilder content: @escaping (CourseMaterial)->Content) {
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.vm = vm
    }
    
    // Offset
    @GestureState var offset: CGFloat = 0
    //@State var currentIndex: Int = -2
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color("SliderBackground"))
                .frame(maxWidth: .infinity)
                .cornerRadius(40)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                
                let width = (proxy.size.width / 5) - (trailingSpace - spacing)
                let adjustmentWidth = 17.5
                
                HStack(spacing: spacing) {
                    ForEach(list) { item in
                        content(item)
                            .frame(width: proxy.size.width / 5)
                            .offset(x: (CGFloat(vm.sliderIndex) * -width) + adjustmentWidth + offset + 5)
                            .onTapGesture(perform: {
                                if vm.autoPlayOn == false {
                                    vm.stopAnimations()
                                    for (index, material) in list.enumerated() {
                                        if material.title == item.title {
                                            vm.sliderIndex = index - 2
                                            vm.materialIndex = index
                                        }
                                    }
                                    //vm.playAnimations()
                                }
                            })
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
                                        vm.sliderIndex = max(min(vm.sliderIndex + Int(roundIndex), list.count - 3), -2)
                                        
                                        //updating index
                                        vm.sliderIndex = index
                                        print(vm.sliderIndex, " ", index)
                                        print(vm.courseMaterials[vm.materialIndex])
                                        
                                        vm.materialIndex = index + 2
                                        
                                        //vm.playAnimations()
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
                                        index = max(min(vm.sliderIndex + Int(roundIndex), list.count - 3), -2)
                                        
                                        vm.stopAnimations()
                                        vm.autoPlayOn = false
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
                .strokeBorder(Color("SliderRingColor"), lineWidth: 5)
                .frame(width: 80, height: 80)
                
        }
    }
}

struct MaterialSnapPicker_Previews: PreviewProvider {
    static var previews: some View {
        LearningPageView(learningPageViewModel: LearningPageViewModel())
    }
}
