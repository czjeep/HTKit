//
//  HTShapeView.swift
//  ToolKit
//
//  Created by caozheng on 2023/4/7.
//

import UIKit

class HTShapeView: UIView {
    
    lazy var shape: CAShapeLayer = {
        return self.layer as! CAShapeLayer
    }()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
}
