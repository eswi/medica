//
//  AddViewController.swift
//  medica
//
//  Created by 위의석 on 2020/02/03.
//  Copyright © 2020 Wi's Works. All rights reserved.
//

import UIKit
import AVFoundation

class AddViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer : CALayer!
    
    var captureDevice : AVCaptureDevice!

    @IBOutlet var hStack: UIStackView!
    @IBOutlet var imageView01: UIImageView!
    @IBOutlet var imageView02: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // eswi:: AddViewㄱ가 올라오면 바로 카메라가 동작하는 것으로 일단~
        prepareCamera()
    }
    
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        captureDevice = discoverySession.devices.first
        
        print("발견한 카메라의 수 : ", discoverySession.devices.count)
        
        beginSession()
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        self.previewLayer = previewLayer
        
        // self.view.layer.addSublayer(self.previewLayer)
        // self.previewLayer.frame = self.view.layer.frame
        
        imageView01.layer.addSublayer(self.previewLayer)
        let rect = CGRect(x: 0, y: -30, width: imageView01.frame.width, height: imageView01.frame.height + 60)
        self.previewLayer.frame = rect
        
        captureSession.startRunning()

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32BGRA)]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
