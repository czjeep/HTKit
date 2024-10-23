//
//  UITextField+Common.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/24.
//

import UIKit

extension UITextField {
    
    /** #warning("rx can't observer if directly set text property") */
    func inputSetText(_ v: String?) {
        let v = v ?? ""
        if let range = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument) {
            self.replace(range, withText: v)
        }
    }
}
