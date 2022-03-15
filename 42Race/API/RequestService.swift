


import Foundation
import Moya
import Alamofire

enum RequestService {
    case getRepos(requestDic: [String: Any])
}

extension RequestService: TargetType {
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string: APIConstant.BASE_URL)!
        }
    }
    
    var path: String {
        switch self {
        case .getRepos(_):
            return APIConstant.getRepos
        }
      
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var headers: [String: String]? {
        return nil 
    }
    
    var task: Task {
        switch self {
        case .getRepos(let requestDic):
            return .requestParameters(parameters: requestDic, encoding: URLEncoding.default)
        }
    }
}



