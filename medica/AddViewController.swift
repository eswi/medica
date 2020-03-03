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

    @IBOutlet var imageStack: UIStackView!
    @IBOutlet var imageView01: UIImageView!
    @IBOutlet var imageView02: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // eswi:: 2020/02/03
        // eswi:: Horizontal Stackview의 너비를 읽어서 높이를 절반으로 맞추면 2개의 imageView가 적당히 정사각혈이 될 것임
        // eswi:: 이 방식이 동작하려면 AutoLayout은 사용하지 않아야 함.
        var stackFrame = imageStack.frame
        stackFrame.size.height = stackFrame.size.width / 2
        imageStack.frame = stackFrame

        // eswi:: AddView가 올라오면 바로 카메라가 동작하는 것으로 일단~
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
        
        // eswi - 2020/02/03
        // 정사각형에 Capture Preview를 맞추었더니 캡처 화면의 높이에 맞추느라고 좌우가 비어서 나오더라.
        // 그래서 높이가 아니라 너비에 맞추고 실제 카메라의 위 아래가 잘리는 방식으로 하면, 정사각형에 꽉 찰 것이므로,
        // frame은 키우고 대상 y 위치를 -(마이너스)로 설정, 즉 올림.
        let newH = imageView01.frame.width/3 * 4        // 확대된 높이를 새로 계산했음.
        let newY = (imageView01.frame.width - newH) / 2 // 확대된 높이의 절반맘만큼 올리면 좌우는 안 잘리고 사진의 정 가운데 토막이 나옴.

        let rect = CGRect(x: 0, y: newY, width: imageView01.frame.width, height: newH)
        
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
