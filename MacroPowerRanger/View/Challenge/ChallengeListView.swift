//
//  PracticeListView.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import SwiftUI

struct ChallengeListView: View {
    @ObservedObject var viewModel = ChallengeListViewModel()
    
    var body: some View {
            ZStack{
                VStack{
                    List{
                        ForEach(viewModel.challenges, id: \.id){ challenge in
                            NavigationLink(destination: ChallengeView()){
                                ChallengeListCellView(
                                    title: challenge.title,
                                    bgImage: challenge.bgImage
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
        ChallengeListView()
    }
}
