//
//  Grouping.swift
//  ToDoList
//
//  Created by Ejaz Merchant on 3/5/18.
//  Copyright © 2018 Ejaz Merchant. All rights reserved.
//

import Foundation
import RealmSwift

class Grouping: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
