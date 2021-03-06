//
//  CategoryModel.swift
//  42Race
//
//  Created by Dev on 3/17/22.
//

import Foundation
import ObjectMapper

struct CategoryModel: Mappable, Equatable {

    var alias: String = ""
    var title: String = ""
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        alias <- map["alias"]
        title <- map["title"]
    }
}
