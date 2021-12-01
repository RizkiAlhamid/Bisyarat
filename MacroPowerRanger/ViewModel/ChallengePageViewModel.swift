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
    @Published var startTimer = 3
    @Published var guestTimer = 5
    @Published var isTimesUp = false
    
    @Published var shouldShowQuestion = false
    
    @Published var isHandInFrame = false
    
    @Published var materialBeingAsked = ""
    @Published var shouldStartClassifying = false
    @Published var isGuessedTrue = false
    
    @Published var currentProgress: Double = 0
    
    @Published var dismissChallenge = false
    @Published var showTutorial = true
    
    @Published var continueChallenge = false
    
    var challengeTitle: String = "Alfabet 1"
    
    var correctAnswerCounter = 0
    var wrongAnserCounter = 0
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        fetchChallengeMaterials(challenge: ChallengeSampleData.challenges[0])
        materialBeingAsked = challengeMaterials[materialIndex].title
        //currentProgress = 1 / Double(challengeMaterials.count)
    }
    
    init(challenge: Challenge) {
        fetchChallengeMaterials(challenge: challenge)
        challengeTitle = challenge.title
        //currentProgress = 1 / Double(challengeMaterials.count)
    }
    
    func refreshState() {
        materialIndex = 0
        startTimer = 3
        guestTimer = 7
        isHandInFrame = false
        isGuessedTrue = false
        shouldStartClassifying = false
        isTimesUp = false
        shouldShowQuestion = false
        materialBeingAsked = challengeMaterials[materialIndex].title
        currentProgress = 0
        correctAnswerCounter = 0
        wrongAnserCounter = 0
    }
    
    func fetchChallengeMaterials(challenge: Challenge) {
        challengeMaterials = challenge.challengeMaterials
    }
    
    func nextMaterial() {
        if isGuessedTrue {
            correctAnswerCounter += 1
        } else {
            wrongAnserCounter += 1
        }
        
        if materialIndex < challengeMaterials.count - 1 {
            materialIndex += 1
            guestTimer = 7
            isTimesUp = false
            isGuessedTrue = false
            shouldStartClassifying = false
            shouldShowQuestion = true
            materialBeingAsked = challengeMaterials[materialIndex].title
            currentProgress = Double(materialIndex) / Double(challengeMaterials.count)
        } else {
            currentProgress = 1
            
            let key = "Tantangan \(challengeTitle)"
            let score: Double = Double(correctAnswerCounter) / Double(challengeMaterials.count)
            
            if score > UserDefaults.standard.double(forKey: key) {
                UserDefaults.standard.set(score, forKey: key)
            }
        }
    }
    
    func getUserProgress() -> Double {
        let progress: Double = Double(materialIndex + 1)
        let total: Double = Double(challengeMaterials.count)
        
        return progress / total
    }
    
    func nextChallenge() {
        fetchChallengeMaterials(challenge: ChallengeSampleData.challenges[1])
        refreshState()
        // ganti title
        challengeTitle = ChallengeSampleData.challenges[1].title
        continueChallenge = true
    }
}
