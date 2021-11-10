//
//  PracticeView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/3/21.
//

import SwiftUI

struct PracticeView: UIViewControllerRepresentable {
    var pointsProcessorHandler: (([CGPoint]) -> Void)?
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cvc = CameraViewController()
        cvc.pointsProcessorHandler = pointsProcessorHandler
        return cvc
    }
    
    func updateUIViewController(
        _ uiViewController: CameraViewController,
        context: Context
    ) {
    }
}
