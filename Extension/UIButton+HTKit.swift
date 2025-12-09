//
//  UIButton+HTKit.swift
//  WuKongKit
//
//  Created by weitu on 2024/11/19.
//

import UIKit
import SDWebImage

extension UIButton {
    
    func setImage(with urlString: String?, for state: UIButton.State, placeholder: UIImage?) {
        var url: URL?
        if let v = urlString {
            url = URL(string: v)
        }
        sd_setImage(with: url, for: state, placeholderImage: placeholder)
    }
    
    func setImage(with urlString: String?, for state: UIButton.State, placeholderImageName: String?) {
        var url: URL?
        if let v = urlString {
            url = URL(string: v)
        }
        var placeholder: UIImage?
        if let t = placeholderImageName {
            placeholder = .bundleImage(t)
        }
        sd_setImage(with: url, for: state, placeholderImage: placeholder)
    }
}
