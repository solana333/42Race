
//  42Race
//
//  Created by Phuoc on 3/15/22.
//


import Foundation
import Moya
import Alamofire
import ObjectMapper
import RxSwift


let provider = MoyaProvider<RequestService>()

protocol RequestProtocol {
    func getBusinesses() ->  Observable<[BusinessModel]>
}

final class RequestManager {

    private init () {}
    
    // MARK: - Shared Instance
    static let shared: RequestManager = RequestManager()

    func searchBusiness(text: String, completion: @escaping ([BusinessModel]) -> Void) {
        let parameters: [String: Any] = [
            "longitude": 103.78667472615952,
            "latitude": 1.296940431677624,
            "term" : text
        ]
        provider.request(.getBusinesses(requestDic: parameters)) { result in
            do {
                switch result {
                case .success(let response):
                    guard let json = try response.mapJSON() as? [String: Any] else {
                        completion([])
                        return
                    }
                    print(String(describing: response.request))
                    print(String(describing: json))
                    guard let businessesJson = json["businesses"] else {
                        completion([])
                        return
                    }
                    guard let response = Mapper<BusinessModel>().mapArray(JSONObject: businessesJson) else  {
                        completion([])
                        return
                    }
                    completion(response)
                case .failure(let error):
                    completion([])
                    print(error)
                }
            } catch let error {
                completion([])
                print(error)
            }
        }
    }
}


class ResponseError {
    static let invalidJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
}

