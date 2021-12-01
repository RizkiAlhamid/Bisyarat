//
//  VideoCapture.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/15/21.
//

import Foundation
import AVFoundation

class PracticeVideoCapture: NSObject {
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    
    var predictor = PracticePredictor()
    
    override init() {
        super.init()

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

extension PracticeVideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
