//
//  MockDataService.swift
//  42RaceTests
//
//  Created by Dev on 3/18/22.
//

import Foundation


class MockDataService : RequestProtocol {

    var business: [BusinessModel] = []
    var error: Error?

    func searchBusiness(text: String, completion: @escaping ([BusinessModel], Error?) -> Void) {
        if let error = error {
            completion(business, error)
        } else {
            completion(business, nil)
        }

    }
}
