//
//  ProductViewController.swift
//  Store
//
//  Created by Айк on 16.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import UIKit

protocol ProductViewControllerDelegate: class {
    func product(viewController: ProductViewController, didAddProduct product: Product)
    func product(viewController: ProductViewController, didUpdateProduct product: Product)
    func product(viewController: ProductViewController, didRemoveProduct product: Product?)
}

class ProductViewController: UIViewController {

    weak var delegate: ProductViewControllerDelegate?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productCountTextField: UITextField!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productTitleTextField.text = product?.title
        productCountTextField.text = "\(product?.count ?? 0)"
        productPriceTextField.text = "\(product?.price ?? 0)"
    }
    
    @IBAction func saveTrigger(_ sender: Any) {
        startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.stopLoading()
            let title = self.productTitleTextField.text ?? ""
            let price = Double(self.productPriceTextField.text ?? "") ?? 0.0
            let count = Int(self.productCountTextField.text ?? "") ?? 0
            
            if self.product != nil {
                self.product?.title = title
                self.product?.price = price
                self.product?.count = count
                self.delegate?.product(viewController: self, didUpdateProduct: self.product!)
            } else {
                let newProduct = Product(title: title, count: count, price: price)
                self.delegate?.product(viewController: self, didAddProduct: newProduct)
            }
        }
    }
    
    @IBAction func deleteTrigger(_ sender: Any) {
        startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.stopLoading()
            self.delegate?.product(viewController: self, didRemoveProduct: self.product)
        }
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}
