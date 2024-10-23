//
//  TinyHTTPRequestImpl.swift
//  HiLeiaDomain
//
//  Created by caozheng on 2022/8/19.
//

import Foundation

/// 上传文件请求，需要自行选择Response
struct UploadTinyHTTPRequest<T: TinyHTTPDecodable>: TinyHTTPRequest {
    
    let origin: String
    let path: String
    var header: [String : String] = [:]
    let method: TinyHTTPMethod = .post
    let contentType: TinyHTTPContentType = .multipart
    /// 这些参数将会被用在body里
    private(set) var parameter: Any?
    
    var timeoutInterval: TimeInterval = 15
    
    typealias Response = T
    
    init(origin: String, path: String) {
        self.origin = origin
        self.path = path
    }
    
    init(urlString: String) {
        let tup = urlString.tup()
        self.init(origin: tup.origin, path: tup.path)
    }
    
    mutating func configFile(name: String, fileName: String, contentType: String, data: Data) {
        var parameter = [String: Any]()
        parameter["name"] = name
        parameter["fileName"] = fileName
        parameter["contentType"] = contentType
        parameter["data"] = data
        
        self.parameter = parameter
    }
}

/// 普通的数据请求，需要自行选择Response
struct DataTinyHTTPRequest<T: TinyHTTPDecodable>: TinyHTTPRequest {
    
    let origin: String
    let path: String
    var header: [String : String] = [:]
    let method: TinyHTTPMethod
    let contentType: TinyHTTPContentType
    var parameter: Any?
    
    var timeoutInterval: TimeInterval = 15
    
    typealias Response = T
    
    init(origin: String, path: String, method: TinyHTTPMethod, contentType: TinyHTTPContentType) {
        self.origin = origin
        self.path = path
        self.method = method
        self.contentType = contentType
    }
    
    init(urlString: String, method: TinyHTTPMethod, contentType: TinyHTTPContentType) {
        let tup = urlString.tup()
        self.init(origin: tup.origin, path: tup.path, method: method, contentType: contentType)
    }
    
    /// 支持Encodable的参数
    mutating func configParameter(_ parameters: Encodable) throws {
        let jsonObj: Any
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        } catch {
            throw error
        }
        
        self.parameter = jsonObj
    }
    
    
}

fileprivate
extension String {
    
    func tup() -> (origin: String, path: String) {
        // 处理包含中文
        guard let urlStr = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStr) else {
            TinyHTTPLog.i("warning can't create url from str: \(self)")
            return ("", "")
        }
        
        var origin = ""
        if let temp = url.scheme {
            origin = temp + "://"
        }
        
        let host: String?
        if #available(iOS 16.0, *) {
            host = url.host()
        } else {
            host = url.host
        }
        if let temp = host {
            origin += temp
        }
        
        if let temp = url.port {
            origin += ":\(temp)"
        }
        
        let originCount = origin.count
        let pathCount = urlStr.count - originCount
        let path = String(urlStr.suffix(pathCount))
        
        return (origin, path)
    }
}
