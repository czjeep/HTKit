//
//  UIImageView+Common.swift
//  HiLeia6
//
//  Created by caozheng on 2021/10/19.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(with urlString: String?, placeholder: UIImage?) {
        var url: URL?
        if let v = urlString {
            url = URL(string: v)
        }
        sd_setImage(with: url, placeholderImage: placeholder)
    }
    
    func setImage(with urlString: String?, placeholderImageName: String?) {
        var url: URL?
        if let v = urlString {
            url = URL(string: v)
        }
        var placeholder: UIImage?
        if let t = placeholderImageName {
            placeholder = .bundleImage(t)
        }
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}
