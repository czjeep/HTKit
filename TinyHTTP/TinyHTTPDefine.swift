import Foundation

enum TinyHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum TinyHTTPContentType: String {
    case form, json, multipart
}


protocol TinyHTTPDecodable {
    init(data: Data, resp: URLResponse?) throws
}

struct TinyHTTPError: LocalizedError {
    
    let code: Int
    let message: String
    
    /// 实现Error.localizedDescription。you may need to use LocalizedError rather than Error and implement errorDescription.
    var errorDescription: String? {
        return message
    }
    
    static let parseFail = Self(code: 90404, message: "网络数据解析失败")
    
    init(code: Int, message: String?) {
        self.code = code
        self.message = message ?? ""
    }
    
    init(_ data: Error) {
        let temp = data as NSError
        self.code = temp.code
        self.message = temp.localizedDescription
    }
    
    init(_ message: String) {
        self.code = -2
        self.message = message
    }
}


//请求参数
protocol TinyHTTPRequest {
    var path: String { get }
    var origin: String { get }

    var header: [String: String] { get }
    /// when the value is TinyHTTPMethod.get, ignore contentType
    var method: TinyHTTPMethod { get }
    var contentType: TinyHTTPContentType { get }
    /// 必须是json对象
    var parameter: Any? { get }
    
    var timeoutInterval: TimeInterval { get }
    
    associatedtype Response: TinyHTTPDecodable
}


//请求中心
protocol TinyHTTPSevice {
    
    static var shared: Self { get }
    
    func send<T: TinyHTTPRequest>(_ req: T, successHandler: ((T.Response) -> Void)?, errorHandler:((TinyHTTPError) -> Void)?)
    
    /// https时是否需要ssl验证
    var enableSSL: Bool { set get }
}
