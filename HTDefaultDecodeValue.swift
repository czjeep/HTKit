//
//  HTDefaultDecodeValue.swift
//  WuKongKit
//
//  Created by weitu on 2025/1/13.
//

import Foundation

//MARK: 增加HTCodable支持
///有默认值的Codable类型
protocol HTCodable {
    associatedtype Value: Codable
    /// 解码没有字段的默认值
    static var defaultDecodeValue: Value { get }
}

@propertyWrapper
struct HTDefaultDecodeValue<T: HTCodable> {
    var wrappedValue: T.Value
}

extension HTDefaultDecodeValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultDecodeValue
    }
}

extension HTDefaultDecodeValue: Encodable {
    func encode(to encoder: any Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(
        _ type: HTDefaultDecodeValue<T>.Type,
        forKey key: Key
    ) throws -> HTDefaultDecodeValue<T> where T: HTCodable {
        try decodeIfPresent(type, forKey: key) ?? HTDefaultDecodeValue(wrappedValue: T.defaultDecodeValue)
    }
}


