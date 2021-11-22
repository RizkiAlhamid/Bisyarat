//
//  CameraView.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/22/21.
//

import Foundation
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    var vm: ChallengePageViewModel
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cvc = CameraViewController(vm: vm)
        return cvc
    }
    
    func updateUIViewController(
        _ uiViewController: CameraViewController,
        context: Context
    ) {
        
    }
}
