//
//  ProductViewController.swift
//  Store
//
//  Created by Айк on 16.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

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
        //productImageView.image = product.image
    }
}
