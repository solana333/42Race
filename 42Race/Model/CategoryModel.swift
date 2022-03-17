//
//  CategoryModel.swift
//  42Race
//
//  Created by BeLive on 3/17/22.
//

import Foundation
import ObjectMapper

struct CategoryModel: Mappable {

    var alias: String = ""
    var title: String = ""
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        alias <- map["alias"]
        title <- map["title"]
    }
}
