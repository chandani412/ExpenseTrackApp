//
//  Expense+CoreDataProperties.swift
//  ExpenseTrackApp
//
//  Created by Chandani on 25/12/21.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: String?
    @NSManaged public var date: String?
    @NSManaged public var notes: String?
    @NSManaged public var category: String?

}

extension Expense : Identifiable {

}
