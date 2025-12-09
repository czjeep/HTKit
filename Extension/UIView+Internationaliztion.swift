//
//  UIView+Internationaliztion.swift
//  MeetHR
//
//  Created by weitu on 2025/12/8.
//

import UIKit

fileprivate var customLocalizedHandler:((String) -> String)?

func setCustomLocalizedHandler(_ handler: @escaping ((String) -> String)) {
    customLocalizedHandler = handler
}

///默认使用NSLocalizedString。优先使用customLocalizedHandler如果已实现
func HTLocalized(_ key: String) -> String {
    if let t = customLocalizedHandler {
        return t(key)
    } else {
        return NSLocalizedString(key, comment: "")
    }
}

func HTLocalized(_ key: String, _ arguments: CVarArg...) -> String {
    return String(format: HTLocalized(key), arguments)
}

extension UILabel {
    
    @IBInspectable var localized: Bool {
        set {
            if newValue {
                if let key = text {
                    text = HTLocalized(key)
                }
            }
        }
        get {
            return false
        }
    }
}

extension UIButton {
    
    @IBInspectable var localized: Bool {
        set {
            if newValue {
                if let key = title(for: .normal) {
                    setTitle(HTLocalized(key), for: .normal)
                }
                if let key = title(for: .selected) {
                    setTitle(HTLocalized(key), for: .selected)
                }
                if let key = title(for: .disabled) {
                    setTitle(HTLocalized(key), for: .disabled)
                }
                if let key = title(for: .highlighted) {
                    setTitle(HTLocalized(key), for: .highlighted)
                }
            }
        }
        get {
            return false
        }
    }
}
