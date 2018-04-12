//
//  Item.swift
//  ToDoList
//
//  Created by Ejaz Merchant on 3/5/18.
//  Copyright © 2018 Ejaz Merchant. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Grouping.self, property: "items")
}
