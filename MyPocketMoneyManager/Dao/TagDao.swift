//
//  TagsDao.swift
//  EasyPcketMoneyManager
//
//  Created by daisuke tsurimoto on 2022/08/09.
//

import UIKit
import CoreData

class TagDao {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func getAll() -> [Tag] {
        do {
            let tags = try context.fetch(Tag.fetchRequest())
            return tags
        } catch {
            print("error")
        }
        return []
    }
    
    public func existsTag(tagName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tag")
        fetchRequest.predicate = NSPredicate(format: "name = %@", tagName)
        do {
            let tags = try context.fetch(fetchRequest) as! [Tag]
            return tags.count > 0
        } catch {
            print("error")
        }
        return false
    }
    
    public func save(name: String, order: Int16) -> Void {
        let tag = Tag(context: context)
        tag.id = UUID().uuidString
        tag.name = name
        tag.order = order
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    public func update(entity: Tag, newName: String) -> Void {
        entity.setValue(newName, forKey: "name")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    public func delete(tag: Tag) -> Void {
        context.delete(tag)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
