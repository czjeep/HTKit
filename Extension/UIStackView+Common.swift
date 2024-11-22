//
//  UIStackView+Common.swift
//  WuKongKit
//
//  Created by weitu on 2024/10/17.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubview() {
        let t = arrangedSubviews
        t.forEach({
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
    }
}
