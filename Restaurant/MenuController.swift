//
//  MenuController.swift
//  RestaurantGuidedProject
//
//  Created by student15 on 4/26/19.
//  Copyright © 2019 student15. All rights reserved.
//

import UIKit
//need to request the list from the API. Packing all the n etwork code into single controller. This will reduce the amount of code in the table view controllers and simplify any future updates.
class MenuController {
    
    static let shared = MenuController()
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
   
    
  
    //a method that has one parameter with a completion closre an array of strings
    func fetchCategories(completion: @escaping ([String]?) -> Void)
    {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL)
        { (data, response, error) in
            if let data = data,
            let jsonDictionary = try?
            JSONSerialization.jsonObject(with: data) as? [String:Any],
                let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    //deserialize each dictionary into a menu item object. The method will perform the request to 2 parameters, the catagory string and in the completion closure a string of array menu items.
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL)
        { (data, response, error) in
           let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    //Requesting the right image
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    //Method to post an order has a collection of menu item IDs, includes also an integer specifying the number of minutes the order will take to prep. For both of those the method needs 2 parameters.
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
      let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           let jsonDecoder = JSONDecoder()
            if let data = data,
            let preparationTime = try?
                jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}

