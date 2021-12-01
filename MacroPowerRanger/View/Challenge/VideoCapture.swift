//
//  VideoCapture.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/15/21.
//

import Foundation
import AVFoundation

class VideoCapture: NSObject {
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    
    var vm: ChallengePageViewModel
    
    var predictor : Predictor
    
//    override init() {
//        super.init()
//
//        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
//              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
//                  return
//              }
//
//        captureSession.sessionPreset = AVCaptureSession.Preset.high
//        captureSession.addInput(input)
//
//        captureSession.addOutput(videoOutput)
//        videoOutput.alwaysDiscardsLateVideoFrames = true
//        let connection = videoOutput.connection(with: AVMediaType.video)
//        connection?.videoOrientation = .portrait
//    }
    
    init(vm: ChallengePageViewModel) {
        self.vm = vm
        //super.init(nibName: nil, bundle: nil)
        
        //super.init()
        predictor = Predictor(vm: vm)
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
                  return
              }
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
        
        captureSession.addOutput(videoOutput)
        videoOutput.alwaysDiscardsLateVideoFrames = true
        let connection = videoOutput.connection(with: AVMediaType.video)
        connection?.videoOrientation = .portrait
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startCaptureSession() {
        captureSession.startRunning()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
    
    func stopCaptureSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
