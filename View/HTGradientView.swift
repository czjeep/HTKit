//
//  GradientView.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/19.
//

import UIKit

class HTGradientView: UIView {
    
    lazy var gradient: CAGradientLayer = {
        return self.layer as! CAGradientLayer
    }()
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    @objc func configGradient(from start: CGPoint, to end: CGPoint, with colors: [UIColor]) {
        gradient.colors = colors.map({ $0.cgColor })
        gradient.startPoint = start
        gradient.endPoint = end
    }
    
    func setLocations(_ arr: [CGFloat]?) {
        gradient.locations = arr?.map({ NSNumber(value: $0) })
    }
    
    @objc func horizontalGradient(with colors: [UIColor]) {
        configGradient(from: .init(x: 0, y: 0), to: .init(x: 1, y: 0), with: colors)
    }
    
    @objc func verticalGradient(with colors: [UIColor]) {
        configGradient(from: .init(x: 0, y: 0), to: .init(x: 0, y: 1), with: colors)
    }
    
}
