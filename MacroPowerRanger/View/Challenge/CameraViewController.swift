//
//  CameraViewController.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 09/11/21.
//

import UIKit
import AVFoundation
import Vision

final class CameraViewController: UIViewController {
    
    var vm: ChallengePageViewModel
    
    let videoCapture = VideoCapture()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var pointsLayer = CAShapeLayer()

    var isRightHandActionDetected = false
    var isLeftHandActionDetected = false
    
    init(vm: ChallengePageViewModel) {
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
    
    private func setupVideoPreview() {
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        
        guard let previewLayer = previewLayer else {
            return
        }
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.green.cgColor
    }
    
}

extension CameraViewController: PredictorDelegate {
    
    func rightHandPredictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if action == "A" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "I" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "J" && confidence > 0.95 && isRightHandActionDetected == false{
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "R" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.vm.materialBeingAsked == "R" {
                    self.vm.isGuessedTrue = true
                }
                self.isRightHandActionDetected = false
            }
        } else if action == "F Kanan" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "E : B Kanan" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "C : D kanan" && confidence > 0.95 && isRightHandActionDetected == false {
            print("Kanan: ", action)
            isRightHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else if action == "Other" && isRightHandActionDetected == false && confidence > 0.75 {
            //isActionDetected = true
            //showLabel(actionLabel: action)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("other")
                self.isRightHandActionDetected = false
            }
        }
        

    }
    
    func leftHandPredictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if action == "A" && confidence > 0.95 && isLeftHandActionDetected == false {
            print("Kiri: ", action)
            isLeftHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLeftHandActionDetected = false
            }
        } else if action == "Telunjuk" && confidence > 0.95 && isLeftHandActionDetected == false {
            print("Kiri: ", action)
            isLeftHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLeftHandActionDetected = false
            }
        } else if action == "C : D kanan" && confidence > 0.95 && isLeftHandActionDetected == false {
            print("Kiri: ", action)
            isLeftHandActionDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLeftHandActionDetected = false
            }
        } else if action == "Other" && isLeftHandActionDetected == false && confidence > 0.75 {
            //isActionDetected = true
            //showLabel(actionLabel: action)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("other")
                self.isLeftHandActionDetected = false
            }
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
            if points.count == 10 {
                self.vm.isHandInFrame = true 
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
    
//    ///
//    private var cameraView: CameraPreview { view as! CameraPreview }
//
//    private let videoDataOutputQueue = DispatchQueue(
//        label: "CameraFeedOutput",
//        qos: .userInteractive
//    )
//    private var cameraFeedSession: AVCaptureSession?
//    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
//        let request = VNDetectHumanHandPoseRequest()
//        request.maximumHandCount = 2
//        return request
//    }()
//
//    var pointsProcessorHandler: (([CGPoint]) -> Void)?
//
//    override func loadView() {
//        view = CameraPreview()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        do {
//            if cameraFeedSession == nil {
//                try setupAVSession()
//                cameraView.previewLayer.session = cameraFeedSession
//                cameraView.previewLayer.videoGravity = .resizeAspectFill
//            }
//            cameraFeedSession?.startRunning()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        cameraFeedSession?.stopRunning()
//        super.viewWillDisappear(animated)
//    }
//
//    func setupAVSession() throws {
//        // Select a front facing camera, make an input.
//        guard let videoDevice = AVCaptureDevice.default(
//            .builtInWideAngleCamera,
//            for: .video,
//            position: .front)
//        else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not find a front facing camera."
//            )
//        }
//
//        guard let deviceInput = try? AVCaptureDeviceInput(
//            device: videoDevice
//        ) else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not create video device input."
//            )
//        }
//
//        let session = AVCaptureSession()
//        session.beginConfiguration()
//        session.sessionPreset = AVCaptureSession.Preset.high
//
//        // Add a video input.
//        guard session.canAddInput(deviceInput) else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not add video device input to the session"
//            )
//        }
//        session.addInput(deviceInput)
//
//        let dataOutput = AVCaptureVideoDataOutput()
//        if session.canAddOutput(dataOutput) {
//            session.addOutput(dataOutput)
//            // Add a video data output.
//            dataOutput.alwaysDiscardsLateVideoFrames = true
//            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
//        } else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not add video data output to the session"
//            )
//        }
//        session.commitConfiguration()
//        cameraFeedSession = session
//    }
//}
//
//extension
//CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
//}
