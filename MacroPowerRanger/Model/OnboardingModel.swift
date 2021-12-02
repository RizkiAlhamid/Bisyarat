//
//  OnboardingModel.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 03/11/21.
//

import SwiftUI

struct OnboardingModel: Identifiable{
    var id = UUID()
    var bgImage: String
    var title: String
    var description: String
    var showsButton: Bool
    }


var onboardingScreens: [OnboardingModel] = [
    OnboardingModel(id: UUID(),bgImage: "Onboarding 1", title: "BISINDO dalam genggamanmu", description: "Belajar BISINDO dengan mudah kapanpun dan dimanapun",showsButton: false),
    OnboardingModel(id: UUID(), bgImage: "Onboarding 2", title: "Mudah belajar bersama Bisma", description: "Gerakan isyarat diperagakan oleh Bisma, karakter 3 Dimensi.",showsButton: false),
    OnboardingModel(id: UUID(), bgImage: "Onboarding 3", title: "Tantang dirimu", description: "Tingkatkan kemampuanmu dengan bantuan teknologi pengenalan gerakan",showsButton: true)
]


