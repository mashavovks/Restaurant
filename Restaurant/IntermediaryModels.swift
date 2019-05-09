//
//  IntermediaryModels.swift
//  RestaurantGuidedProject
//
//  Created by student15 on 4/26/19.
//  Copyright © 2019 student15. All rights reserved.
//

import Foundation
//the API can be used to return a list of categories, an array of strings under the key categories. This is an intermediate object used for decoding the data that contains menu items
struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
        
    }
}


