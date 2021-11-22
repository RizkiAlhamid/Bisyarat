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
    
    init(){
        fetchPractices()
    }
    
    func fetchPractices(){
        challenges = ChallengeSampleData.challenges
    }
}
