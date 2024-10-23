//
//  CommonExtension.swift
//  PinNotes
//
//  Created by caozheng on 2023/3/7.
//

import UIKit

extension UIColor {
    
    /// rgb或者rgba。eg: #242424
    convenience init?(_ hexString: String) {
        guard hexString.hasPrefix("#") else {
            return nil
        }
        
        let pureStr = hexString.dropFirst()
        if pureStr.count == 8, let hex = Int(pureStr, radix: 16) {
            self.init(rgbaHex: hex)
        } else if pureStr.count == 6, let hex = Int(pureStr, radix: 16){
            self.init(rgbHex: hex)
        } else {
            return nil
        }
    }
    
    /// rgba数值
    convenience init(rgbaHex: Int) {
        let r, g, b, a: CGFloat
        
        r = CGFloat((rgbaHex & 0xff000000) >> 24) / 255
        g = CGFloat((rgbaHex & 0xff0000) >> 16) / 255
        b = CGFloat((rgbaHex & 0xff00) >> 8) / 255
        a = CGFloat(rgbaHex & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// rgb数值
    convenience init(rgbHex: Int, alpha: CGFloat = 1) {
        let r, g, b, a: CGFloat
        
        r = CGFloat((rgbHex & 0xff0000) >> 16) / 255
        g = CGFloat((rgbHex & 0xff00) >> 8) / 255
        b = CGFloat(rgbHex & 0xff) / 255
        a = alpha
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// rgb字符串
    func rgbHexString() -> String {
        let rgb = rgbHex()
        return String(format:"#%06x", rgb)
    }
    
    /// rgb数值
    func rgbHex() -> Int {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return rgb
    }
}
