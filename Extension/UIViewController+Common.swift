//
//  UIViewController+Common.swift
//  ToolKit
//
//  Created by caozheng on 2023/4/7.
//

import UIKit

extension UIViewController {
    
    func setViewControllerOrientation(_ orientation: UIInterfaceOrientation) {
//        let mask = UIInterfaceOrientationMask(
//        if #available(iOS 16.0, *) {
//            appSceneDelegate?.window?.windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
//        } else {
            UIDevice.current.setValue(
                orientation.rawValue,
              forKey: "orientation"
            )
//        }
    }
    
    enum AddAnimateType {
        case `default`
        case side
    }
    
    func addToContainer(_ parent: UIViewController, containerView: UIView? = nil, belowSubview: UIView? = nil, animateType: AddAnimateType = .default, duration: TimeInterval = 0.75, completion: ((Bool) -> Void)? = nil) {
        parent.addChild(self)
        if let belowSubview = belowSubview {
            parent.view.insertSubview(view, belowSubview: belowSubview)
            view.frame = parent.view.bounds
        } else if let containerView = containerView {
            containerView.addSubview(view)
            view.frame = containerView.bounds
        } else {
            parent.view.addSubview(view)
            view.frame = parent.view.bounds
        }
        if animateType == .side, let containerView = containerView {
            view.frame.origin.x = containerView.bounds.width
        } else if animateType == .side {
            view.frame.origin.x = parent.view.bounds.width
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.alpha = 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.alpha = 1
            self?.view.frame.origin.x = 0
        } completion: { [weak self] finished in
            self?.view.alpha = 1
            self?.view.frame.origin.x = 0
            self?.didMove(toParent: parent)
            completion?(finished)
        }
    }
    
    func removeFromContainer() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func removeFromNavigationAsyn(completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { [weak self] in
            self?.navigationController?.viewControllers.removeAll(where: { $0 === self })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                completion?()
            })
        }
    }
}
