//
//  DefaultValue.swift
//  WuKongKit
//
//  Created by weitu on 2025/1/13.
//

import Foundation

//有默认值的类型
protocol JsonValueType {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
struct JsonProperty<T: JsonValueType> {
    var wrappedValue: T.Value
}

extension JsonProperty: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension JsonProperty: Encodable {
    func encode(to encoder: any Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(
        _ type: JsonProperty<T>.Type,
        forKey key: Key
    ) throws -> JsonProperty<T> where T: JsonValueType {
        try decodeIfPresent(type, forKey: key) ?? JsonProperty(wrappedValue: T.defaultValue)
    }
}

extension Bool {
    
    ///默认值false
    enum False: JsonValueType {
        static let defaultValue = false
    }
    
    ///默认值true
    enum True: JsonValueType {
        static let defaultValue = true
    }
}

extension JsonProperty {
    typealias True = JsonProperty<Bool.True>
    typealias False = JsonProperty<Bool.False>
}

extension Int {
    
    ///默认值0
    enum Int0: JsonValueType {
        static let defaultValue: Int = 0
    }
    
    ///默认值1
    enum Int1: JsonValueType {
        static let defaultValue: Int = 1
    }
    
    ///默认值-1
    enum IntNeg1: JsonValueType {
        static let defaultValue: Int = 1
    }
}

extension JsonProperty {
    typealias Int0 = JsonProperty<Int.Int0>
    typealias Int1 = JsonProperty<Int.Int1>
    typealias IntNeg1 = JsonProperty<Int.IntNeg1>
}

extension String {
    
    ///默认值空字符串
    enum StringEmtpy: JsonValueType {
        static let defaultValue: String = ""
    }
}

extension JsonProperty {
    typealias StringEmtpy = JsonProperty<String.StringEmtpy>
}
