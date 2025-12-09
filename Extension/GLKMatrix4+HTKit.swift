//
//  GLKMatrix4+HTKit.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import Foundation
import GLKit

extension GLKMatrix4 {
    
    var float4x4: simd_float4x4 {
        let col0: SIMD4<Float> = .init(m00, m01, m02, m03)
        let col1: SIMD4<Float> = .init(m10, m11, m12, m13)
        let col2: SIMD4<Float> = .init(m20, m21, m22, m23)
        let col3: SIMD4<Float> = .init(m30, m31, m32, m33)
        return .init(col0, col1, col2, col3)
    }
    
    var array: [Float] {
        return [m00, m01, m02, m03,
                m10, m11, m12, m13,
                m20, m21, m22, m23,
                m30, m31, m32, m33]
    }
    
}
