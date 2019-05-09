//
//  MenuTableViewController.swift
//  RestaurantGuidedProject
//
//  Created by student15 on 4/25/19.
//  Copyright © 2019 student15. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    //string property to hold category data it is an implicity unwrapped optional meaning when an optional is determined and can be assumed to exist thereafter
    let menuController = MenuController()
    var menuItems = [MenuItem]()
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.capitalized
        MenuController.shared.fetchMenuItems(forCategory: category) {
            (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
                
            }
        }
    }
//after the network request above is made, the argument here is checked in the closure to see if it contains data and then passes the data to this method that sets the property and updates the interface.
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }
    //Below is code that makes the number of cells in the table equal to the size of the array of menu items. The left side of the label displays the item name and the right side displays the price.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        //code below specifies how much decimal places to display. the format string %.2f tells the initializer that the argument should be displayed with 2 digits
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) {
            (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                
                cell.imageView?.image = image
                cell.setNeedsLayout()
                
            }
            
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // prepares the segue in menuTableViewController. Segue is equal to menuDetailSegue. It passes the menu item from one view controller to the other.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailViewController = segue.destination
            as! MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuItemDetailViewController.menuItem = menuItems[index]
        }
    }
   

}
