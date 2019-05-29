//
//  CoreDataManager.swift
//  Store
//
//  Created by Айк on 29.05.2019.
//  Copyright © 2019 Vardan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(product: Product) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ProductModel", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(product.title, forKey: "title")
        manageObject.setValue(product.count, forKey: "count")
        manageObject.setValue(product.price, forKey: "price")
        manageObject.setValue(product.image, forKey: "image")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func updateObject(product: ProductModel, newProduct: Product) -> Bool {
        let context = getContext()
        product.setValuesForKeys([
            "title": newProduct.title,
            "count": newProduct.count,
            "price": newProduct.price,
            "image": newProduct.image ?? ""
        ])
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func removeObject(model: ProductModel) -> Bool {
        let context = getContext()
        context.delete(model)
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func fetchObjects() -> [ProductModel] {
        let context = getContext()
        var objects: [ProductModel] = []
        do {
            let managedObjects = try context.fetch(ProductModel.fetchRequest()) as? [ProductModel]
            if let managedObjects = managedObjects {
                objects = managedObjects
            }
            return objects
        } catch {
            return objects
        }
    }
}
