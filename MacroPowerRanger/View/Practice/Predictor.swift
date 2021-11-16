//
//  Predictor.swift
//  Bisyarat
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/15/21.
//

import Foundation
import Vision

protocol PredictorDelegate: AnyObject {
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
}

class Predictor {
    
    weak var delegate: PredictorDelegate?
    
    func estimation(sampleBuffer: CMSampleBuffer) {
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        
        let request = VNDetectHumanHandPoseRequest(completionHandler: handPoseHandler)
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request, with error: \(error)")
        }
    }
    
    func handPoseHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNHumanHandPoseObservation] else { return }
        
        observations.forEach {
            processObservation($0)
        }
    }
    
    func processObservation(_ observation: VNHumanHandPoseObservation) {
        do {
            let recognizedPoints = try observation.recognizedPoints(.all)
            
            var displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
            }
            
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        } catch {
            print("error finding recognizedPoints")
        }
    }
}
