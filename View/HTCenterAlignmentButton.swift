//
//  HTCenterAlignmentButton.swift
//  HiMeta
//
//  Created by lft on 2023/5/25.
//

import UIKit

@objc enum UIButtonTitleImageAlignment: Int {
    case AlignmentHorizontalCenter
    case AlignmentVerticalCenter
}

class HTCenterAlignmentButton: UIButton {
     
    @IBInspectable var titleImageSpace: CGFloat = 0 {
        didSet {
            layoutImageAndTitle()
        }
    }
    @IBInspectable var titleImageAlignment: UIButtonTitleImageAlignment = .AlignmentHorizontalCenter {
        didSet {
            layoutImageAndTitle()
        }
    }
    
    func layoutImageAndTitle() {
        if titleImageAlignment == .AlignmentVerticalCenter {
            let imageW = imageView?.frame.width ?? 0
            let imageH = imageView?.frame.height ?? 0
            
            let titleW = titleLabel?.frame.width ?? 0
            let titleH = titleLabel?.frame.height ?? 0
            
            // 图片上文字下
            let space = titleImageSpace
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageW, bottom: -imageH - space, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: -titleH, left: 0, bottom: 0, right: -titleW)
        } else {
            let space = titleImageSpace
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space/2)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: 0)
        }
    }

}
