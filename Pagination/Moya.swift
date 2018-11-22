//
//  ApiAPI.swift
//
//  Generated usign MoyaPaw Export https://github.com/narlei/SwiftMoyaCodeGenerator.git

import Moya



public enum ApiAPI {
    case Request (api_key: String, page: Int)
}

extension ApiAPI: TargetType {
    public var headers: [String : String]? {
        return nil
    }
    
    
    public var baseURL: URL { return URL(string: "https://api.themoviedb.org")! }
    
    public var path: String {
        switch self {
        case .Request:
            return "/3/movie/popular"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .Request:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .Request (let api_key, let page):
            return .requestParameters(parameters: ["api_key": api_key, "page": page], encoding: URLEncoding.default)
        }
    }
    public var sampleData: Data {
        switch self {
        case .Request :
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
}
