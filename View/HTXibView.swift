//
//  HTXibView.swift
//  HiLeia6
//
//  Created by caozheng on 2021/10/18.
//

import UIKit

class HTXibView: UIView {
    
    lazy var xibView: UIView = {
        let obj = UINib(nibName: "\(type(of: self))", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    private func xibSetup() {
        addSubview(xibView)
        //让xibview充满self
        if xibView.translatesAutoresizingMaskIntoConstraints {  //xibview本身为非约束布局时充满
            xibView.frame = bounds
            xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        } else {  //xibview本身为约束布局时充满
            NSLayoutConstraint(item: xibView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: xibView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: xibView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: xibView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        }
        
        initial()
    }
    
    func initial() {
        
    }
    
}
