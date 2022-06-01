//
//  Predictor.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/15/21.
//

import Foundation
import Vision

protocol PracticePredictorDelegate: AnyObject {
    func predictor(_ predictor: PracticePredictor, didFindNewRecognizedPoints points: [CGPoint], hand: String)
    func rightHandPredictor(_ predictor: PracticePredictor, didLabelAction action: String, with confidence: Double)
    func leftHandPredictor(_ predictor: PracticePredictor, didLabelAction action : String, with confidence: Double)
}

class PracticePredictor {
    
    weak var delegate: PracticePredictorDelegate?
    
    let predictionWindowSize = 30
    var rightHandPosesWindow: [VNHumanHandPoseObservation] = []
    var leftHandPosesWindow: [VNHumanHandPoseObservation] = []
    
    init() {
        rightHandPosesWindow.reserveCapacity(predictionWindowSize)
        leftHandPosesWindow.reserveCapacity(predictionWindowSize)
    }
    
    func estimation(sampleBuffer: CMSampleBuffer) {
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        
        //let request = VNDetectHumanHandPoseRequest(completionHandler: handPoseHandler)
        
        let handPoseRequest: VNDetectHumanHandPoseRequest = {
            let request = VNDetectHumanHandPoseRequest()
            request.maximumHandCount = 2
            return request
        }()
        
        do {
            try requestHandler.perform([handPoseRequest])
            
            //guard let results = handPoseRequest.results?.prefix(2), !results.isEmpty else {return}
            guard let results = handPoseRequest.results, !results.isEmpty else {return}
            
//            for hand in results {
//                if hand.chirality == .right {
//                    processObservation(hand, hand: "right")
//                } else if hand.chirality == .left {
//                    processObservation(hand, hand: "left")
//                }
//            }
            
            processObservationPoints(results)
            
//            if let result = results.first {
//                storeObservation(result)
//
//                labelActionType()
//            }
            
            results.forEach { result in
                if result.chirality == .right {
                    storeRightHandObservation(result)
                    labelRightHandActionType()
                } else if result.chirality == .left {
                    storeLeftHandObservation(result)
                    labelLeftHandActionType()
                }
            }
            
        } catch {
            print("Unable to perform the request, with error: \(error)")
        }
    }
    
    func labelRightHandActionType() {
        guard let bisindoClassifier = try? BisyaratChallenge1New_1(configuration: MLModelConfiguration()),
              let poseMultiArray = prepareInputWithObservations(rightHandPosesWindow),
              let predictions = try? bisindoClassifier.prediction(poses: poseMultiArray) else {
                  return
                  
              }
        
        let label = predictions.label
        let confidence = predictions.labelProbabilities[label] ?? 0
        delegate?.rightHandPredictor(self, didLabelAction: label, with: confidence)
    }
    
    func labelLeftHandActionType() {
        guard let bisindoClassifier = try? BisyaratChallenge1New_1(configuration: MLModelConfiguration()),
              let poseMultiArray = prepareInputWithObservations(leftHandPosesWindow),
              let predictions = try? bisindoClassifier.prediction(poses: poseMultiArray) else {
                  return
                  
              }
        
        let label = predictions.label
        let confidence = predictions.labelProbabilities[label] ?? 0
        delegate?.leftHandPredictor(self, didLabelAction: label, with: confidence)
    }
    
    func prepareInputWithObservations(_ observations: [VNHumanHandPoseObservation]) -> MLMultiArray? {
        let numAvailableFrames = observations.count
        let observationsNeeded = 30
        var multiArrayBuffer = [MLMultiArray]()
        
        for frameIndex in 0 ..< min(numAvailableFrames, observationsNeeded) {
            let pose = observations[frameIndex]
            do {
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            } catch {
                continue
            }
        }
        
        if numAvailableFrames < observationsNeeded {
            for _ in 0 ..< (observationsNeeded - numAvailableFrames) {
                do {
                    let oneFrameMultiArray = try MLMultiArray(shape: [1, 3, 21], dataType: .double)
                    try resetMultiArray(oneFrameMultiArray)
                    multiArrayBuffer.append(oneFrameMultiArray)
                } catch {
                    continue
                }
            }
        }
        
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float)
    }
    
    func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws {
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow)
        pointer.initialize(repeating: value)
    }
    
    func storeRightHandObservation(_ observation: VNHumanHandPoseObservation) {
        
        if rightHandPosesWindow.count >= predictionWindowSize {
            rightHandPosesWindow.removeFirst()
        }
        
        rightHandPosesWindow.append(observation)
    }
    
    func storeLeftHandObservation(_ observation: VNHumanHandPoseObservation) {
        
        if leftHandPosesWindow.count >= predictionWindowSize {
            leftHandPosesWindow.removeFirst()
        }
        
        leftHandPosesWindow.append(observation)
    }
    
    func processObservation(_ observation: VNHumanHandPoseObservation, hand: String) {
        do {
            let recognizedPoints = try observation.recognizedPoints(.all)
            
            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
            }
            
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints, hand: hand)
        } catch {
            print("error finding recognizedPoints")
        }
    }
    
    func processObservationPoints(_ observations: [VNHumanHandPoseObservation]) {
        do {
            var recognizedPoints: [VNRecognizedPoint] = []
            
            try observations.forEach { observation in

                let fingers = try observation.recognizedPoints(.all)
                // Look for tip points.
                if let thumbTipPoint = fingers[.thumbTip] {
                  recognizedPoints.append(thumbTipPoint)
                }
                if let indexTipPoint = fingers[.indexTip] {
                  recognizedPoints.append(indexTipPoint)
                }
                if let middleTipPoint = fingers[.middleTip] {
                  recognizedPoints.append(middleTipPoint)
                }
                if let ringTipPoint = fingers[.ringTip] {
                  recognizedPoints.append(ringTipPoint)
                }
                if let littleTipPoint = fingers[.littleTip] {
                  recognizedPoints.append(littleTipPoint)
                }
                
            }
            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.location.x, y: 1 - $0.location.y)
            }
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints, hand: "right")

        } catch {
            
        }
        
    }
}
