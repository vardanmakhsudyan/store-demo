//
//  Product.swift
//  Store
//
//  Created by Айк on 18.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import Foundation

class Product {
    var title: String
    var count: Int
    var price: Double
    var image: String?
    
    init(title: String, count: Int, price: Double, image: String? = nil) {
        self.title = title
        self.count = count
        self.price = price
        self.image = image
    }
}
