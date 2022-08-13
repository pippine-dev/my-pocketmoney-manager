//
//  FixedCostsDao.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/09.
//

import UIKit
import CoreData

class FixedCostsDao: NSObject {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func getAll() -> [FixedCosts] {
        do {
            let fixedCosts = try context.fetch(FixedCosts.fetchRequest())
            return fixedCosts
        } catch {
            print("error")
        }
        return []
    }
    
    public func existsFixedCost(fixedCostName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FixedCosts")
        fetchRequest.predicate = NSPredicate(format: "name = %@", fixedCostName)
        do {
            let fixedCosts = try context.fetch(fetchRequest) as! [FixedCosts]
            return fixedCosts.count > 0
        } catch {
            print("error")
        }
        return false
    }
    
    public func save(name: String, amount: Int32) -> Void {
        let fixedCosts = FixedCosts(context: context)
        fixedCosts.id = UUID().uuidString
        fixedCosts.name = name
        fixedCosts.amount = amount
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    public func update(entity: FixedCosts, newName: String, newAmount: Int32) -> Void {
        entity.setValue(newName, forKey: "name")
        entity.setValue(newAmount, forKey: "amount")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    public func delete(fixedCost: FixedCosts) -> Void {
        context.delete(fixedCost)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
