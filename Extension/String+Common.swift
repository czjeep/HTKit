//
//  String+Common.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/17.
//

import UIKit

extension String {
    
    func attributedString(foregroundColor: UIColor, font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.foregroundColor: foregroundColor, .font: font])
    }
    
    func mutableAttributedString(foregroundColor: UIColor, font: UIFont) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: foregroundColor, .font: font])
    }
    
    func attributedString(attr: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attr)
    }
}

extension NSAttributedString {
    
    @available(iOS 15, *)
    var attributedString: AttributedString { AttributedString(self) }
}


public extension String {
    
    /// Check if self has the given substring in case-sensitiv or case-insensitive.
    ///
    /// - Parameters:
    ///   - string: The substring to be searched.
    ///   - caseSensitive: If the search has to be case-sensitive or not.
    /// - Returns: Returns true if founded, otherwise false.
    func range(of string: String, caseSensitive: Bool = true) -> Bool {
        caseSensitive ? (range(of: string) != nil) : (lowercased().range(of: string.lowercased()) != nil)
    }
    
    /// Check if self has the given substring in case-sensitiv or case-insensitive.
    ///
    /// - Parameters:
    ///   - string: The substring to be searched.
    ///   - caseSensitive: If the search has to be case-sensitive or not.
    /// - Returns: Returns true if founded, otherwise false.
    func has(_ string: String, caseSensitive: Bool = true) -> Bool {
        range(of: string, caseSensitive: caseSensitive)
    }
    
    /// Creates a substring with a given range.
    ///
    /// - Parameter range: The range.
    /// - Returns: Returns the string between the range.
    func substring(with range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)

        return String(self[start..<end])
    }
}

extension String {
    
    func setPrefixIfNoHttp(_ str: String) -> String {
        if self.hasPrefix("http") {
            return self
        } else {
            if self.hasPrefix("/") {
                return str + self
            } else {
                return str + "/" + self
            }
        }
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
}

extension Optional {
    
    /// 当为nil或者字符串为空时使用设置的值
    func useWhenNilOrEmpty(_ value: Wrapped) -> Wrapped where Wrapped == String {
        switch self {
        case .none:
            return value
        case .some(let wrapped):
            if wrapped.isEmpty {
                return value
            } else {
                return wrapped
            }
        }
    }
}

extension String {
    
    func removeLastIfContains(_ str: String) -> String {
        var t = self
        if t.hasSuffix(str) {
            t.removeLast(str.count)
        }
        return t
    }
}

extension String {
    
    var jsonObj: Any? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    var jsonDic: [String: Any]? {
        return jsonObj as? [String: Any]
    }
}
