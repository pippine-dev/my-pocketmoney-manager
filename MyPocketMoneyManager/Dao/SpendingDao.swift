//
//  PocketMoneyDao.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/09.
//

import UIKit
import CoreData

class SpendingDao {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateUtils = DateUtils()
    
    public func getAll() -> [Spending] {
        do {
            let fetchRequest = Spending.fetchRequest()
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(key: "year", ascending: true),
                NSSortDescriptor(key: "month", ascending: true),
                NSSortDescriptor(key: "day", ascending: true)]
            
            let spendings = try context.fetch(Spending.fetchRequest())
            
            return spendings
        } catch {
            print("error")
        }
        return []
    }
    
    public func getAllYear() -> [Int16] {
        var result: [Int16] = []
        
        let spendings = getAll()
        for spending in spendings {
            if !result.contains(spending.year) {
                result.append(spending.year)
            }
        }
        return result
    }
    
    public func getAllMonth() -> [Int16] {
        var result: [Int16] = []
        
        let spendings = getAll()
        for spending in spendings {
            if !result.contains(spending.month) {
                result.append(spending.month)
            }
        }
        return result
    }
    
    public func getTotalAmountThisMonth() -> Int {
        let today = Date()
        
        let expressionAmountName = "amount"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Spending", in: context)
        fetchRequest.entity = entityDescription
        
        let keyPathExpression = NSExpression(forKeyPath: "amount")
        let expression = NSExpression(forFunction: "sum:", arguments: [keyPathExpression])
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = expressionAmountName
        expressionDescription.expression = expression
        expressionDescription.expressionResultType = NSAttributeType.integer32AttributeType
        
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        fetchRequest.propertiesToFetch = [expressionDescription]
        fetchRequest.predicate = NSPredicate(format: "year = %d and month = %d and day between {%d, %d}", dateUtils.getYear(date: today), dateUtils.getMonth(date: today), dateUtils.getDay(date: dateUtils.getFirstDate()), dateUtils.getDay(date: dateUtils.getLastDate()))
        
        do {
            let results = try context.fetch(fetchRequest)
            if let totalAmount = ((results.first as AnyObject).value(forKey: expressionAmountName)) as? Int {
                return totalAmount
            } else{
                return 0
            }
        } catch {
            print("error")
        }
        
        return 0
    }
    
    public func existsFixedCostWithinThisMonth(fixedCostName: String) -> Bool {
        let today = Date()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Spending")
        fetchRequest.predicate = NSPredicate(format: "fixedCostName = %@ and year = %d and month = %d", fixedCostName, dateUtils.getYear(date: today), dateUtils.getMonth(date: today))
        do {
            let pocketMoney = try context.fetch(fetchRequest) as! [Spending]
            return pocketMoney.count > 0
        } catch {
            print("error")
        }
        return false
    }
    
    public func getAmountWithTag(tagName: String) -> Int {
        let today = Date()
        
        let expressionAmountName = "amount"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Spending", in: context)
        fetchRequest.entity = entityDescription
        
        let keyPathExpression = NSExpression(forKeyPath: "amount")
        let expression = NSExpression(forFunction: "sum:", arguments: [keyPathExpression])
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = expressionAmountName
        expressionDescription.expression = expression
        expressionDescription.expressionResultType = NSAttributeType.integer32AttributeType
        
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        fetchRequest.propertiesToFetch = [expressionDescription]
        fetchRequest.predicate = NSPredicate(format: "tagName = %@ and year = %d and month = %d and day between {%d, %d}", tagName, dateUtils.getYear(date: today), dateUtils.getMonth(date: today), dateUtils.getDay(date: dateUtils.getFirstDate()), dateUtils.getDay(date: dateUtils.getLastDate()))
        
        do {
            let results = try context.fetch(fetchRequest)
            if let totalAmount = ((results.first as AnyObject).value(forKey: expressionAmountName)) as? Int {
                return totalAmount
            } else{
                return 0
            }
        } catch {
            print("error")
        }
        
        return 0
    }
    
    public func save(amount: Int32, tagName: String?) -> Void {
        let today = Date()
        
        let pocketMoney = Spending(context: context)
        pocketMoney.year = Int16(dateUtils.getYear(date: today))
        pocketMoney.month = Int16(dateUtils.getMonth(date: today))
        pocketMoney.day = Int16(dateUtils.getDay(date: today))
        pocketMoney.amount = amount
        pocketMoney.tagName = tagName
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
