import Foundation

final class TinyHTTPSeviceCenter: NSObject, TinyHTTPSevice {
    
    static let shared = TinyHTTPSeviceCenter()
    
    private var session: URLSession!
    
    var enableSSL = true
    
    private override init() {
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    func send<T: TinyHTTPRequest>(_ req: T, successHandler: ((T.Response) -> Void)?, errorHandler:((TinyHTTPError) -> Void)?) {
        let req = URLRequest(req)
        
        TinyHTTPLog.i("reqeust url: \(req.url?.absoluteString ?? "")")
        TinyHTTPLog.i("reqeust httpMethod: \(req.httpMethod ?? "")")
        TinyHTTPLog.i("request httpHeader: \(req.allHTTPHeaderFields ?? [:])")
        if let data = req.httpBody {
            TinyHTTPLog.condition {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    TinyHTTPLog.i("request httpBody json: \(json)")
                } else {
                    TinyHTTPLog.i("request httpBody count: \(data.count)")
                }
            }
        } else {
            TinyHTTPLog.i("request httpBody nil")
        }
        
        let task = session.dataTask(with: req) {
            data, resp, err in
            
            TinyHTTPLog.i("response url: \(resp?.url?.absoluteString ?? "")")
            if let temp = resp as? HTTPURLResponse {
                TinyHTTPLog.i("response statusCode: \(temp.statusCode)")
            }
            if let temp = data {
                TinyHTTPLog.condition {
                    if let json = try? JSONSerialization.jsonObject(with: temp, options: []) {
                        TinyHTTPLog.i("response json: \(json), \(type(of: json))")
                    } else {
                        TinyHTTPLog.i("response data json failed: \(temp.count)")
                    }
                }
            } else {
                TinyHTTPLog.i("response data nil")
            }
            
            var (response, error): (T.Response?, TinyHTTPError?)
            (response, error) = self.handleResponse(request: req, data: data, res: resp, err: err)

            if let temp = error {
                TinyHTTPLog.i(temp)
                errorHandler?(temp)
            } else if let temp = response {
                successHandler?(temp)
            }
        }
        task.resume()
    }
    
    func handleResponse<T: TinyHTTPDecodable>(request: URLRequest, data: Data?, res: URLResponse?, err: Error?) -> (T?, TinyHTTPError?) {
        if let temp = err {
            return (nil, TinyHTTPError(temp))
        } else if let temp = data {
            do {
                let res = try T(data: temp)
                return (res, nil)
            } catch {
                return (nil, .init(error))
            }
        } else if let temp = res as? HTTPURLResponse {
            return (nil, TinyHTTPError(code: temp.statusCode, message: temp.description))
        } else {
            return (nil, TinyHTTPError("无法解析响应头"))
        }
    }
}

extension TinyHTTPSeviceCenter: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // 判断认证质询的类型，判断是否存在服务器信任实例 serverTrust
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
            let serverTrust = challenge.protectionSpace.serverTrust else {
                // 否则使用默认处理
                completionHandler(.performDefaultHandling, nil)
                return
        }
        // 自定义方法，对服务器信任实例 serverTrust 进行评估
        if evaluate(serverTrust, for: challenge.protectionSpace.protocol) {
            // 评估通过则创建 URLCredential 实例，告诉系统接受服务器的凭据
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            // 否则取消这次认证，告诉系统拒绝服务器的凭据
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    func evaluate(_ serverTrust: SecTrust, for scheme: String?) -> Bool {
        var trust : Bool = false
        if #available(iOS 12, *) {
            var error: CFError?
            trust = SecTrustEvaluateWithError(serverTrust, &error)
            if let temp = error {
                debugPrint("serverTrust error: ", temp)
            }
        } else {
            var result = SecTrustResultType.invalid
            let status = SecTrustEvaluate(serverTrust, &result)
            trust = (status == errSecSuccess && (result == .unspecified || result == .proceed))
        }
        
        TinyHTTPLog.i("evaluate trust: \(trust), \(scheme ?? "")")
        
        if scheme == "https", enableSSL, !trust {
            TinyHTTPLog.i("绕过ssl")
            return true
        }
        
        return trust
    }

}
