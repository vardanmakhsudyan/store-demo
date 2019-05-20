//
//  StoreTableViewController.swift
//  Store
//
//  Created by Айк on 16.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {

    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        products = [
            Product(title: "iPhone", count: 5, price: 100),
            Product(title: "iPhone 3G", count: 3, price: 200),
            Product(title: "iPhone 3GS", count: 2, price: 300)
        ]
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ProductTableViewCell

        // Configure the cell...
        let product = products[indexPath.row]
        cell.productTitleLabel.text = product.title
        cell.productCountLabel.text = "\(product.count)"
        cell.productPriceLabel.text = "\(product.price)"
//        cell.productImageView.image = product.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = products[indexPath.row]
        performSegue(withIdentifier: "ProductDetails", sender: product)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ProductDetails", let product = sender as? Product {
            if let vc = segue.destination as? ProductViewController {
               vc.product = product
            }
        }
    }

    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "ProductDetails", sender: nil)
    }
    
}
