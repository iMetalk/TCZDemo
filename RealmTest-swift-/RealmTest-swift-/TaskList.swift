//
//  TaskList.swift
//  RealmTest-swift-
//
//  Created by 武卓 on 2017/8/10.
//  Copyright © 2017年 武卓. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList: Object {
    
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    let taskList = List<Task> ()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
