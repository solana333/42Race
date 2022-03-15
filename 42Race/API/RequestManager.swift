


import Foundation
import Moya
import Alamofire
import ObjectMapper
import RxSwift


let provider = MoyaProvider<RequestService>()

final class RequestManager {
    private init () {}
    
    // MARK: - Shared Instance
    static let shared: RequestManager = RequestManager()
    
    static func requestJsonRx(api: RequestService) -> Observable<Any> {
        return Observable.create({ observer -> Disposable in
            let request = provider.request(api, completion: { result in
                do {
                    switch result {
                    case .success(let response):
                        let json = try response.mapJSON()
                        observer.onNext(json)
                        observer.onCompleted()
                    case .failure(let error):
                        throw error
                    }
                } catch let error {
                    observer.onError(error)
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
    

    static func getRepos(requestDic: [String: Any]) -> Observable<[Repository]> {
        return requestJsonRx(api: .getRepos(requestDic: requestDic)).map({ json in
            if let response = Mapper<Repository>().mapArray(JSONObject: json) {
                return response
            } else {
                throw ResponseError.invalidJSONFormat
            }
        })
    }
}


class ResponseError {
    static let invalidJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
}

