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
    var category: [CategoryModel] = []
    var address: String = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        alias <- map["alias"]
        name <- map["name"]
        imageUrl <- map["image_url"]
        isClosed <- map["is_closed"]
        reviewCount <- map["review_count"]
        rating <- map["rating"]
        category <- map["categories"]
        address <- map["location.address1"]
    }

    func getCategory() -> String {
        var category = ""
        for element in self.category {
            category = category + " " + element.title
        }
        return category
    }
}
