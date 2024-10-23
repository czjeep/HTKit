import Foundation

extension URLRequest {
    
    init<T: TinyHTTPRequest>(_ r: T) {
        var origin = r.origin, path = r.path,
        pre = path.hasPrefix("/"), suf = origin.hasSuffix("/")
        if pre && suf {
            let _ = path.removeFirst()
        } else if !pre && !suf && path != "" {
            origin += "/"
        }
        let url = URL(string: origin + path)!
        TinyHTTPLog.i(url)
        
        self.init(url: url)
        var req = self
        for (k, v) in r.header {
            req.addValue(v, forHTTPHeaderField: k)
        }
        req.httpMethod = r.method.rawValue
        let param = r.parameter
        let data: Data?
        switch (r.method, r.contentType) {
        case (.get, _):
            let str = Self.createFormString(param)
            if !str.isEmpty {
                req.url = URL(string: r.origin + r.path + "?" + str)!
            }
            data = nil
        case (_, .form):
            data = Self.createFormString(param).data(using: .utf8)
            let FORM_CONTENT_TYPE = "application/x-www-form-urlencoded; charset=UTF-8"
            req.addValue(FORM_CONTENT_TYPE, forHTTPHeaderField: "Content-Type")
        case (_, .json):
            data = createJsonData(with: param)
            let JSON_CONTENT_TYPE = "application/json"
            req.addValue(JSON_CONTENT_TYPE, forHTTPHeaderField: "Content-Type")
        case (_, .multipart):
            let boundary = "wfWiEWrgEFA9A78512weF7106A"
            req.addValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
            data = createMultipart(param, boundary: boundary)
            if let temp = data {
                req.addValue("\(temp.count)", forHTTPHeaderField: "Content-Length")
            }
        }
        req.httpBody = data
        req.timeoutInterval = r.timeoutInterval
        self = req
    }
    
    static
    func createFormString(_ ao: Any?) -> String {
        guard let aAo = ao, let json = aAo as? [String: Any] else {
            TinyHTTPLog.i("can't create form with \(String(describing: ao)), need a dic")
            return ""
        }
        
        return createFormString(json)
    }
    
    static
    func createFormString(_ json: [String: Any]) -> String {
        let text = json.reduce("", { str, item in
            let param: String
            if let intArr = item.value as? Array<Any> {
                param = intArr.map({ "\(item.key)=\($0)"}).joined(separator: "&")
            } else {
                let value: String
                if JSONSerialization.isValidJSONObject(item.value), let data = try? JSONSerialization.data(withJSONObject: item.value, options: []) {
                    value = String(data: data, encoding: String.Encoding.utf8) ?? ""
                } else if let flag = item.value as? Bool {
                    value = flag ? "1" : "0"
                } else if item.value is NSNull {
                    value = ""
                } else {
                    value = "\(item.value)"
                }
                param = "\(item.key)=\(value)"
            }
            return str == "" ? param : (str + "&" + param)
        })
        return text
    }
    
    private func createJsonData(with ao: Any?) -> Data? {
        guard let json = ao else {
            TinyHTTPLog.i("can't create jsonData with \(String(describing: ao)), need a json object")
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return data
        } catch {
            TinyHTTPLog.i("\(error)")
        }
        
        return nil
    }
    
    private func createMultipart(_ ao: Any?, boundary: String) -> Data? {
        guard let aAo = ao, let json = aAo as? [String: Any] else {
            TinyHTTPLog.i("can't create multipart with \(String(describing: ao)), need a dic")
            return nil
        }
        
        return createMultipart(json, boundary: boundary)
    }
    
    private func createMultipart(_ json: [String: Any], boundary: String) -> Data? {
        guard let name = json["name"] as? String,
              let fileName = json["fileName"] as? String,
              let contentType = json["contentType"] as? String,
              let data = json["data"] as? Data
        else {
            var body = Data()
            
            for ele in json {
                let pairData = createPair(name: ele.key, content: ele.value, boundary: boundary)
                body.append(pairData)
            }
            
            let endData = createEnd(boundary: boundary)
            body.append(endData)
            
            return body
        }
        
        var body = Data()
        let pair = "--\(boundary)\r\nContent-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\nContent-Type: \(contentType)\r\n\r\n"
        body.append(pair.data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        let end = "--\(boundary)--\r\n"
        body.append(end.data(using: .utf8)!)
        
        TinyHTTPLog.condition {
            if let temp = String(data: data, encoding: .utf8) {
                TinyHTTPLog.i("multipart:\(temp)")
            } else {
                TinyHTTPLog.i("the multipart data can't encode to utf8 string")
            }
        }
        
        return body
    }
    
    private func createPair(name: String, content: Any, boundary: String) -> Data {
        var result = Data()
        
        let pair = "--\(boundary)\r\nContent-Disposition: form-data; name=\"\(name)\"\r\n\r\n"
        result.append(pair.data(using: .utf8)!)
        if let str = content as? String {
            result.append(str.data(using: .utf8)!)
        }
        result.append("\r\n".data(using: .utf8)!)
        
        return result
    }
    
    private func createEnd(boundary: String) -> Data {
        let end = "--\(boundary)--\r\n"
        return end.data(using: .utf8)!
    }
}
