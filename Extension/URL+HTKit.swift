//
//  URL+HTKit.swift
//  HiLeia.PS
//
//  Created by caozheng on 2022/10/18.
//

import Foundation
import UniformTypeIdentifiers

extension URL {
    
    func getHost() -> String? {
        let host: String?
        if #available(iOS 16.0, *) {
            host = self.host()
        } else {
            host = self.host
        }
        
        return host
    }
    
    func getURLParam() -> [String] {
        let query: String?
        if #available(iOS 16.0, *) {
            query = self.query()
        } else {
            query = self.query
        }
        
        let param = query?.components(separatedBy: "&") ?? []
        return param
    }
}

extension URL {
    
    /// 获取文件属性
    func fileAttributes() -> [FileAttributeKey : Any] {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: relativePath)
            return attributes
        } catch {
            print("无法获取文件属性: \(error)")
        }
        return [:]
    }
    
    /// Determine the file's content type (MIME type)
    func fileType() -> String? {
        if let fileType = UTType(filenameExtension: pathExtension)?.preferredMIMEType {
            return fileType
        } else {
            print("Unable to determine content type")
        }
        return nil
    }
}
