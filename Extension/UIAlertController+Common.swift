//
//  UIAlertController+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import UIKit

extension UIAlertController {
    
    static func saveToAlbumAlert(confirmAction: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "保存到相册", preferredStyle: .alert)
        alert.addAction(.init(title: "确定", style: .default, handler: { _ in
            confirmAction?()
        }))
        alert.addAction(.init(title: "取消", style: .cancel, handler: nil))
        
        return alert
    }
    
    
    func presentBy(_ vc: UIViewController, sourceView: UIView?) {
        if UIDevice.current.userInterfaceIdiom == .pad,
           let sender = sourceView {
            popoverPresentationController?.sourceView = sender
            popoverPresentationController?.sourceRect = sender.bounds
        }
        vc.present(self, animated: true, completion: nil)
    }
}
