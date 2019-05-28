//
//  StoreTableViewController.swift
//  Store
//
//  Created by Айк on 16.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController, UISearchBarDelegate, ProductViewControllerDelegate {

    var products: [Product] = []
    
    var filteredProducts: [Product]  {
        return products.filter({ (product) -> Bool in
            if searchKeyword.isEmpty { return true }
            return product.title.localizedCaseInsensitiveContains(searchKeyword)
        })
    }
    
    var searchKeyword = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        products = [
            Product(title: "iPhone X", count: 5, price: 799),
            Product(title: "iPhone XS", count: 3, price: 999),
            Product(title: "iPhone XS Max", count: 2, price: 1199)
        ]
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        
        tableView.reloadData()
    }

    // MARK: - UISearchBarDelegate
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchBar.text ?? ""
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ProductTableViewCell

        let product = filteredProducts[indexPath.row]
        cell.productTitleLabel.text = product.title
        cell.productCountLabel.text = "\(product.count)"
        cell.productPriceLabel.text = "$\(product.price)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = filteredProducts[indexPath.row]
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
        closeDetail()
    }
    
    func product(viewController: ProductViewController, didUpdateProduct product: Product) {
        if let index = products.firstIndex(where: { $0 === product }) {
            products[index] = product
            tableView.reloadData()
            closeDetail()
        }
    }
    
    func product(viewController: ProductViewController, didRemoveProduct product: Product?) {
        if let index = products.firstIndex(where: { $0 === product }) {
            products.remove(at: index)
            tableView.reloadData()
            closeDetail()
        }
    }
    
    func closeDetail() {
        navigationController?.popViewController(animated: true)
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController?.showDetailViewController(createEmptyViewController(), sender: self)
        }
    }
    
    func createEmptyViewController() -> UIViewController {
        return UIViewController()
    }
}
