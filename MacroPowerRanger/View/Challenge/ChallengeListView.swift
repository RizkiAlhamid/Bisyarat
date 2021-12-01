//
//  PracticeListView.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import SwiftUI

struct ChallengeListView: View {
    @ObservedObject var viewModel = ChallengeListViewModel()
    
    private let gridItems = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    
    var body: some View {
        
            ScrollView{
                LazyVGrid(columns: gridItems, spacing: 20, content: {
                    ForEach(viewModel.challenges, id: \.id){ challenge in
                        NavigationLink(destination: ChallengeView(challengePageViewModel: ChallengePageViewModel.init(challenge: challenge))){
                            ChallengeListCellView(
                                title: challenge.title,
                                bgImage: challenge.bgImage
                            )
                        }
                    }
                }).padding(.top)
            }
        
        //.navigationTitle("Tantangan")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct PracticeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
