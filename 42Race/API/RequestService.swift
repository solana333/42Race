
//  42Race
//
//  Created by Phuoc on 3/15/22.
//


import Foundation
import Moya
import Alamofire

enum RequestService {
    case getBusinesses(requestDic: [String: Any])
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
        case .getBusinesses(_):
            return APIConstant.getBusinesses
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
        case .getBusinesses(let requestDic):
            return .requestParameters(parameters: requestDic, encoding: URLEncoding.default)
        }
    }
}



