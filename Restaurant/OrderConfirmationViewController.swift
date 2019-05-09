//
//  OrderConfirmationViewController.swift
//  RestaurantGuidedProject
//
//  Created by student15 on 5/2/19.
//  Copyright © 2019 student15. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
