//
//  ExpenseObj.swift
//  ExpenseTrackApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit

class ExpenseObj: NSObject {

    public var title: String?
     public var amount: String?
     public var date: String?
     public var notes: String?
     public var category: String?
    init(Title:String, Amount:String, Date:String, Notes:String, Category:String) {
                self.title = Title
                self.amount = Amount
                self.date = Date
                self.notes = Notes
                self.category = Category
            }
}
