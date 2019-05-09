//
//  MenuItem.swift
//  RestaurantGuidedProject
//
//  Created by student15 on 4/25/19.
//  Copyright © 2019 student15. All rights reserved.
//

import Foundation
//the struct conforms to the Codable protocol. This contructs the the data for each item in the menu

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
        //image_url uses an underscore instead of camelcase, this and description (a common property in API) for these, custom non-matching properties must be created for these keys.
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
    
}


