//
//  HTCaptureVideoView.swift
//  Domain
//
//  Created by caozheng on 2021/12/24.
//

import UIKit
import AVFoundation.AVCaptureVideoPreviewLayer

class HTCaptureVideoView: UIView {

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var preview: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    deinit {
        print("HTCaptureVideoView__deinit")
    }

}
