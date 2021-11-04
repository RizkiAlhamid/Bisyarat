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
    OnboardingModel(id: UUID(),bgImage: "bgOnboarding", title: "Selamat datang di Bisyarat", description: "Halo teman baik, terimakasih sudah mendukung Komunitas Tuli di Indonesia dengan mulai belajar BISINDO",showsButton: false),
    OnboardingModel(id: UUID(), bgImage: "bgOnboarding", title: "Bisa ngapain aja di Bisyarat?", description: "Disini kamu bisa belajar bisindo dengan panduan dan melatihnya dengan teknologi Augmented Reality yang canggih 🤩",showsButton: true)
]


