//
//  BusinessModel.swift
//  42Race
//
//  Created by BeLive on 3/16/22.
//

import Foundation
import ObjectMapper

struct BusinessModel: Mappable {

    var id: String = ""
    var alias: String = ""
    var name: String = ""
    var imageUrl: String = ""
    var isClosed: Bool = false
    var reviewCount: Int = 0
    var rating: Double = 0

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        alias <- map["alias"]
        name <- map["name"]
        imageUrl <- map["imageUrl"]
        isClosed <- map["isClosed"]
        reviewCount <- map["reviewCount"]
        rating <- map["rating"]
    }
}
