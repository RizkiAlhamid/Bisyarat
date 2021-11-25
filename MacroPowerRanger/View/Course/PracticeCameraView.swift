//
//  PracticeCameraView.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/25/21.
//

import SwiftUI

struct PracticeCameraView: UIViewControllerRepresentable {
    var vm: PracticePageViewModel
    
    func makeUIViewController(context: Context) -> PracticeCameraViewController {
        let cvc = PracticeCameraViewController(vm: vm)
        return cvc
    }
    
    func updateUIViewController(_ uiViewController: PracticeCameraViewController, context: Context) {
        
    }
}
