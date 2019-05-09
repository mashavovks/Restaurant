//
//  Order.swift
//  RestaurantGuidedProject
//
//  Created by student15 on 4/26/19.
//  Copyright © 2019 student15. All rights reserved.
//

import Foundation
//the order model object will contain a simple list of items the user has added
struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
        
    }
}




