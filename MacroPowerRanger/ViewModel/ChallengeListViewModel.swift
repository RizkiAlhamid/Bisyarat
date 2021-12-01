//
//  PracticeListViewModel.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import Foundation
import SwiftUI

class ChallengeListViewModel: ObservableObject
{
    @Published var challenges = [Challenge]()
    @Published private var refresh = false
    
    init(){
        fetchPractices()
    }
    
    func fetchPractices(){
        challenges = ChallengeSampleData.challenges
    }
    
    func updateView() {
        refresh.toggle()
    }
}
