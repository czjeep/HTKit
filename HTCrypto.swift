//
//  HTCrypto.swift
//  HiARSpaceCore
//
//  Created by caozheng on 2023/3/20.
//

import Foundation
import CommonCrypto

class HTCrypto {
    
    static
    func md5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    static
    func hmacSha256(string: String, secretKey: String) -> Data {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        let mac = UnsafeMutablePointer<CChar>.allocate(capacity: digestLength)
        
        let cSecretKey: [CChar]? = secretKey.cString(using: .utf8)
        let cSecretKeyLength = secretKey.lengthOfBytes(using: .utf8)
        
        let cMessage: [CChar]? = string.cString(using: .utf8)
        let cMessageLength = string.lengthOfBytes(using: .utf8)
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cSecretKey, cSecretKeyLength, cMessage, cMessageLength, mac)
        
        let macData = Data(bytes: mac, count: digestLength)
        
        return macData
    }
    
    static
    func hmacSha1(string: String, secretKey: String) -> Data {
        let digestLength = Int(CC_SHA1_DIGEST_LENGTH)
        let mac = UnsafeMutablePointer<CChar>.allocate(capacity: digestLength)
        
        let cSecretKey: [CChar]? = secretKey.cString(using: .utf8)
        let cSecretKeyLength = secretKey.lengthOfBytes(using: .utf8)
        
        let cMessage: [CChar]? = string.cString(using: .utf8)
        let cMessageLength = string.lengthOfBytes(using: .utf8)
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cSecretKey, cSecretKeyLength, cMessage, cMessageLength, mac)
        
        let macData = Data(bytes: mac, count: digestLength)
        
        return macData
    }
    
    static
    func desEncrypt(source: String, key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> Data? {
        guard let keyData = key.data(using: String.Encoding.utf8),
              let data = source.data(using: String.Encoding.utf8),
              let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeDES) else {
            return nil
        }
        
        let keyLength              = size_t(kCCKeySizeDES)
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmDES)
        let options:   CCOptions   = UInt32(options)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  iv,
                                  (data as NSData).bytes, data.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        guard UInt32(cryptStatus) == UInt32(kCCSuccess) else {
            return nil
        }
        
        cryptData.length = Int(numBytesEncrypted)
        return cryptData as Data
    }
    
    static
    func desDecrypt(data: Data, key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
        let data = data as NSData
        guard let keyData = key.data(using: String.Encoding.utf8),
              let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeDES)
        else {
            return nil
        }
        
        let keyLength              = size_t(kCCKeySizeDES)
        let operation: CCOperation = UInt32(kCCDecrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmDES)
        let options:   CCOptions   = UInt32(options)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  iv,
                                  data.bytes, data.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        guard UInt32(cryptStatus) == UInt32(kCCSuccess) else {
            return nil
        }
        
        cryptData.length = Int(numBytesEncrypted)
        let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
        return unencryptedMessage
    }
}

