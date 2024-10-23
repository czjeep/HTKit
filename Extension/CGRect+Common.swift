//
//  CGRect+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import Foundation

extension CGRect {
    
    /// 以当前rect的左上角为原点，宽度为单位x，高度为单位y，求这个point的数值
    func normalized(_ point: CGPoint) -> CGPoint {
        var size = self.size
        if size.width <= 0 {
            size.width = 1
            print("normalized error width: \(size.width)")
        }
        if size.height <= 0 {
            size.height = 1
            print("normalized error height: \(size.width)")
        }
        
        let width = point.x - origin.x
        let height = point.y - origin.y
        
        return .init(x: width/size.width, y: height/size.height)
    }
    
    /// The center point of the rect. Settable.
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
