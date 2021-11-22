//
//  ChallengePageViewModel.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/22/21.
//

import Foundation


class ChallengePageViewModel: ObservableObject {
    @Published var challengeMaterials = [ChallengeMaterial]()
    @Published var materialIndex: Int = 0
    @Published var timeRemaining = 3
    @Published var isHandInFrame = false
    
    @Published var materialBeingAsked = "R"
    @Published var isGuessedTrue = false
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        fetchChallengeMaterials(challenge: ChallengeSampleData.challenges[0])
    }
    
    init(challenge: Challenge) {
        fetchChallengeMaterials(challenge: challenge)
    }
    
    func refreshState() {
        materialIndex = 0
        timeRemaining = 3
        isHandInFrame = false
        isGuessedTrue = false
    }
    
    func fetchChallengeMaterials(challenge: Challenge) {
        challengeMaterials = challenge.challengeMaterials
    }
    
    
}
