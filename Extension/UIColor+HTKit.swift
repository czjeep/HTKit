//
//  UIColor+HTKit.swift
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
    
    convenience init?(colorDes: String) {
        switch colorDes.lowercased() {
        case "black":
            self.init(cgColor: UIColor.black.cgColor)
        case "darkgray":
            self.init(cgColor: UIColor.darkGray.cgColor)
        case "lightgray":
            self.init(cgColor: UIColor.lightGray.cgColor)
        case "white":
            self.init(cgColor: UIColor.white.cgColor)
        case "gray":
            self.init(cgColor: UIColor.gray.cgColor)
        case "red":
            self.init(cgColor: UIColor.red.cgColor)
        case "green":
            self.init(cgColor: UIColor.green.cgColor)
        case "blue":
            self.init(cgColor: UIColor.blue.cgColor)
        case "cyan":
            self.init(cgColor: UIColor.cyan.cgColor)
        case "yellow":
            self.init(cgColor: UIColor.yellow.cgColor)
        case "magenta":
            self.init(cgColor: UIColor.magenta.cgColor)
        case "orange":
            self.init(cgColor: UIColor.orange.cgColor)
        case "purple":
            self.init(cgColor: UIColor.purple.cgColor)
        case "brown":
            self.init(cgColor: UIColor.brown.cgColor)
        case "clear":
            self.init(cgColor: UIColor.clear.cgColor)
        default:
            return nil
        }
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
    
    /// 随机颜色
    static func random() -> UIColor {
        UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}
