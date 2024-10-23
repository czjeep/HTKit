//
//  HTAspectImageView.swift
//  HiMeta
//
//  Created by caozheng on 2023/6/15.
//

import UIKit

class HTAspectImageView: UIImageView {
    
    private var aspectRatio: NSLayoutConstraint?
    
    override var image: UIImage? {
        didSet{
            guard let image = self.image else {
                return
            }
            let size = image.size
            guard size.height > 0 else {
                return
            }
            aspectRatio?.isActive = false
            aspectRatio = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: size.width/size.height, constant: 0)
            aspectRatio?.isActive = true
        }
    }
}
