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
  // swiftlint:disable:next force_cast
  private var cameraView: CameraPreview { view as! CameraPreview }

  private let videoDataOutputQueue = DispatchQueue(
    label: "CameraFeedOutput",
    qos: .userInteractive
  )
  private var cameraFeedSession: AVCaptureSession?
  private let handPoseRequest: VNDetectHumanHandPoseRequest = {
    let request = VNDetectHumanHandPoseRequest()
    request.maximumHandCount = 2
    return request
  }()

  var pointsProcessorHandler: (([CGPoint]) -> Void)?

  override func loadView() {
    view = CameraPreview()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    do {
      if cameraFeedSession == nil {
        try setupAVSession()
        cameraView.previewLayer.session = cameraFeedSession
        cameraView.previewLayer.videoGravity = .resizeAspectFill
      }
      cameraFeedSession?.startRunning()
    } catch {
      print(error.localizedDescription)
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    cameraFeedSession?.stopRunning()
    super.viewWillDisappear(animated)
  }

  func setupAVSession() throws {
    // Select a front facing camera, make an input.
    guard let videoDevice = AVCaptureDevice.default(
      .builtInWideAngleCamera,
      for: .video,
      position: .front)
    else {
      throw AppError.captureSessionSetup(
        reason: "Could not find a front facing camera."
      )
    }

    guard let deviceInput = try? AVCaptureDeviceInput(
      device: videoDevice
    ) else {
      throw AppError.captureSessionSetup(
        reason: "Could not create video device input."
      )
    }

    let session = AVCaptureSession()
    session.beginConfiguration()
    session.sessionPreset = AVCaptureSession.Preset.high

    // Add a video input.
    guard session.canAddInput(deviceInput) else {
      throw AppError.captureSessionSetup(
        reason: "Could not add video device input to the session"
      )
    }
    session.addInput(deviceInput)

    let dataOutput = AVCaptureVideoDataOutput()
    if session.canAddOutput(dataOutput) {
      session.addOutput(dataOutput)
      // Add a video data output.
      dataOutput.alwaysDiscardsLateVideoFrames = true
      dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
    } else {
      throw AppError.captureSessionSetup(
        reason: "Could not add video data output to the session"
      )
    }
    session.commitConfiguration()
    cameraFeedSession = session
  }
}

extension
CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
}
