
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

    static func requestJsonRx(api: RequestService) -> Observable<[String: Any]> {
        return Observable.create({ observer -> Disposable in
            let request = provider.request(api, completion: { result in
                do {
                    switch result {
                    case .success(let response):
                        let json = try response.mapJSON()
                        if let jsonDict = json as? [String: Any] {
                            observer.onNext(jsonDict)
                            observer.onCompleted()
                        } else {
                           // throw ResponseError.invalidJSONFormat
                            print("throw error here")
                        }
                    case .failure(let error):
                        throw error
                    }
                } catch let error {
                    observer.onError(error)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }

    static func getBusinesses() {
        let parameters: [String: Any] = [
            "longitude": 103.78667472615952,
            "latitude": 1.296940431677624,
            "term" : "he"
        ]
        provider.request(.getBusinesses(requestDic: parameters)) { result in
            do {
                switch result {
                case .success(let response):
                    if let json = try response.mapJSON() as? [String: Any] {
                        print(String(describing: response.request))
                        print(String(describing: json))

                        if let businessesJson = json["businesses"] {
                            if let response = Mapper<BusinessModel>().mapArray(JSONObject: businessesJson) {
                                print(response)
                            }
                        }

                    }
                    //completion(response, nil)
                case .failure(let error):
                    //completion(nil, error)
                    print(error)
                }
            } catch let error {
                //completion(nil, error)
                print(error)
            }
        }
    }
}


class ResponseError {
    static let invalidJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
}

