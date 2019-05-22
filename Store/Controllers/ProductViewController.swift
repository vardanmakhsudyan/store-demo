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

    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productTitleTextField.text = product?.title
        productCountTextField.text = "\(product?.count ?? 0)"
        productPriceTextField.text = "\(product?.price ?? 0)"
    }
    
    @IBAction func saveTrigger(_ sender: Any) {
        let title = productTitleTextField.text ?? ""
        let price = Double(productPriceTextField.text ?? "") ?? 0.0
        let count = Int(productCountTextField.text ?? "") ?? 0
        
        if product != nil {
            product?.title = title
            product?.price = price
            product?.count = count
            delegate?.product(viewController: self, didUpdateProduct: product!)
        } else {
            let newProduct = Product(title: title, count: count, price: price)
            delegate?.product(viewController: self, didAddProduct: newProduct)
        }
    }
    
    @IBAction func deleteTrigger(_ sender: Any) {
        delegate?.product(viewController: self, didRemoveProduct: product)
    }
}
