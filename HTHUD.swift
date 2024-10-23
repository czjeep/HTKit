//
//  HiLeiaHUD.swift
//  HiLeia6
//
//  Created by caozheng on 2021/10/20.
//

import SVProgressHUD

class HTHUD: NSObject {
    
    static func setup() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8))
        SVProgressHUD.setImageViewSize(.zero)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setMaximumDismissTimeInterval(3)
        SVProgressHUD.setCornerRadius(18)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    /// 显示加载动画。要调用dismiss来消失
    static func show() {
        SVProgressHUD.show()
    }
    
    /// 显示加载动画，附带文案。要调用dismiss来消失
    static func show(withStatus status: String?) {
        SVProgressHUD.show(withStatus: status)
    }
    
    /// 消失
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    /// 显示一个成功图标和文案的toaster
    static func showSuccess(withStatus status: String?) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    /// 显示一个错误图标和文案的toaster
    static func showError(withStatus status: String?) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    /// 显示一个文案的toaster
    static func showInfo(withStatus status: String?) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
}
