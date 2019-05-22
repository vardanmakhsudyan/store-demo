//
//  StoreTableViewController.swift
//  Store
//
//  Created by Айк on 16.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController, ProductViewControllerDelegate {

    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        products = [
            Product(title: "iPhone X", count: 5, price: 799),
            Product(title: "iPhone XS", count: 3, price: 999),
            Product(title: "iPhone XS Max", count: 2, price: 1199)
        ]
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ProductTableViewCell

        let product = products[indexPath.row]
        cell.productTitleLabel.text = product.title
        cell.productCountLabel.text = "\(product.count)"
        cell.productPriceLabel.text = "$\(product.price)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "ProductDetails", sender: product)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ProductDetails" {
            if let vc = segue.destination as? ProductViewController {
                vc.product = sender as? Product
                vc.delegate = self
            }
        }
    }

    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "ProductDetails", sender: nil)
    }
    
    // ProductViewControllerDelegate
    func product(viewController: ProductViewController, didAddProduct product: Product) {
        products.append(product)
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func product(viewController: ProductViewController, didUpdateProduct product: Product) {
        if let index = products.firstIndex(where: { $0 === product }) {
            products[index] = product
            tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func product(viewController: ProductViewController, didRemoveProduct product: Product?) {
        if let index = products.firstIndex(where: { $0 === product }) {
            products.remove(at: index)
            tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
    }
}
