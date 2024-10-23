//
//  Encodable+Common.swift
//  WuKongKit
//
//  Created by caozheng on 2024/10/15.
//

import Foundation

extension Encodable {
    
    func data() -> Data? {
        do {
            let result = try JSONEncoder().encode(self)
            return result
        } catch {
            print(error)
        }
        return nil
    }
}
