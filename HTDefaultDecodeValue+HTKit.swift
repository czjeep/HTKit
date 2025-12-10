//
//  HTDefaultDecodeValue+HTKit.swift
//  MeetHR
//
//  Created by weitu on 2025/12/10.
//

import Foundation

//MARK: 增加Bool支持
extension Bool {
    ///默认值false
    enum False: HTCodable {
        static let defaultDecodeValue = false
    }
    
    ///默认值true
    enum True: HTCodable {
        static let defaultDecodeValue = true
    }
}

extension HTDefaultDecodeValue {
    typealias True = HTDefaultDecodeValue<Bool.True>
    typealias False = HTDefaultDecodeValue<Bool.False>
}

//MARK: 增加Int支持
extension Int {
    ///默认值0
    enum Int0: HTCodable {
        static let defaultDecodeValue: Int = 0
    }
    
    ///默认值1
    enum Int1: HTCodable {
        static let defaultDecodeValue: Int = 1
    }
    
    ///默认值-1
    enum IntNeg1: HTCodable {
        static let defaultDecodeValue: Int = 1
    }
    
    ///当前毫秒时间戳
    enum TimestampInMilliseconds: HTCodable {
        static var defaultDecodeValue: Int {
            return Date().timestampInMilliseconds()
        }
    }
}

extension HTDefaultDecodeValue {
    typealias Int0 = HTDefaultDecodeValue<Int.Int0>
    typealias Int1 = HTDefaultDecodeValue<Int.Int1>
    typealias IntNeg1 = HTDefaultDecodeValue<Int.IntNeg1>
    typealias TimestampInMilliseconds = HTDefaultDecodeValue<Int.TimestampInMilliseconds>
}

//MARK: 增加String支持
extension String {
    ///默认值空字符串
    enum StringEmtpy: HTCodable {
        static let defaultDecodeValue: String = ""
    }
}

extension HTDefaultDecodeValue {
    typealias StringEmtpy = HTDefaultDecodeValue<String.StringEmtpy>
}
