//
//  PracticeCameraViewController.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/25/21.
//

import UIKit
import SwiftUI
import AVFoundation
import Vision

final class PracticeCameraViewController: UIViewController {
    
    var vm: PracticePageViewModel
    
    let videoCapture = VideoCapture()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var pointsLayer = CAShapeLayer()
    
    var isRightHandActionDetected = false
    var isLeftHandActionDetected = false
    
    var leftHandActionName = ""
    
    init(vm: PracticePageViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPreview()
        videoCapture.predictor.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoCapture.stopCaptureSession()
    }
    
    private func setupVideoPreview() {
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        
        guard let previewLayer = previewLayer else {
            return
        }
        
        
        //previewLayer.frame = view.frame
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        
        //view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.green.cgColor
    }
}


extension PracticeCameraViewController: PredictorDelegate {
    func rightHandPredictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if action == "A" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "A" {
                    if self.leftHandActionName == "A" {
                        self.vm.isGuessedTrue = true
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "I" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "I" {
                    self.vm.isGuessedTrue = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "J" && confidence > 0.95 && isRightHandActionDetected == false{
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "J" {
                    self.vm.isGuessedTrue = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "R" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "R" {
                    self.vm.isGuessedTrue = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "F Kanan" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "F" {
                    if self.leftHandActionName == "Telunjuk" {
                        self.vm.isGuessedTrue = true
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "E : B Kanan" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "E" {
                    self.vm.isGuessedTrue = true
                } else if self.vm.materialPractice.title == "B" {
                    if self.leftHandActionName == "Telunjuk" {
                        self.vm.isGuessedTrue = true
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "C : D kanan" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if self.vm.materialPractice.title == "C" {
                    self.vm.isGuessedTrue = true
                } else if self.vm.materialPractice.title == "D" {
                    if self.leftHandActionName == "Telunjuk" {
                        self.vm.isGuessedTrue = true
                    }
                } else if self.vm.materialPractice.title == "S" {
                    if self.leftHandActionName == "C : D kanan" {
                        self.vm.isGuessedTrue = true
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "Other" && isRightHandActionDetected == false && confidence > 0.75 {
            //isActionDetected = true
            //showLabel(actionLabel: action)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                print("other")
                self.isRightHandActionDetected = false
            }
        }
        
        
        
        
    }
    
    func leftHandPredictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if action == "A" && confidence > 0.95 && isLeftHandActionDetected == false {
            print("Kiri: ", action)
            isLeftHandActionDetected = true
            leftHandActionName = action
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLeftHandActionDetected = false
            }
        } else if action == "Telunjuk" && confidence > 0.95 && isLeftHandActionDetected == false {
            print("Kiri: ", action)
            isLeftHandActionDetected = true
            leftHandActionName = action
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLeftHandActionDetected = false
            }
        } else if action == "C : D kanan" && confidence > 0.95 && isLeftHandActionDetected == false {
            print("Kiri: ", action)
            isLeftHandActionDetected = true
            leftHandActionName = action
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLeftHandActionDetected = false
            }
        } else if action == "Other" && isLeftHandActionDetected == false && confidence > 0.75 {
            //isActionDetected = true
            //showLabel(actionLabel: action)
            leftHandActionName = action
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("other")
                self.isLeftHandActionDetected = false
            }
        } else {
            //leftHandActionName = ""
        }
        
        
        //        if isLeftHandActionDetected == true {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                self.isLeftHandActionDetected = false
        //            }
        //        }
        
    }
    
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint], hand: String) {
        guard let previewLayer = previewLayer else { return }
        
        let convertedPoints = points.map {
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        let combinedPath = CGMutablePath()
        
        for point in convertedPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 5, height: 5))
            combinedPath.addPath(dotPath.cgPath)
        }
        
        pointsLayer.path = combinedPath
        
        DispatchQueue.main.async {
            if points.count >= 5 {
                //self.vm.isHandInFrame = true
            } else {
                //self.vm.isHandInFrame = false
            }
            self.pointsLayer.didChangeValue(for: \.path)
            if hand == "left" {
                self.pointsLayer.strokeColor = UIColor.yellow.cgColor
            } else {
                self.pointsLayer.strokeColor = UIColor.green.cgColor
            }
        }
    }
}
