//
//  PracticeListView.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import SwiftUI

struct PracticeListView: View {
    @ObservedObject var viewModel = PracticeListViewModel()
    
    var body: some View {
            ZStack{
                VStack{
                    List{
                        ForEach(viewModel.practices, id: \.id){practice in
                            NavigationLink(destination: PracticeView()){
                                PracticeCellView(
                                    title: practice.title,
                                    bgImage: practice.bgImage
                                )
                            }
                        }
                    }
                }
                .navigationTitle("Latihan")
            }
    }
}

struct PracticeListView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeListView()
    }
}
