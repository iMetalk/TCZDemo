//
//  Task.swift
//  RealmTest-swift-
//
//  Created by 武卓 on 2017/8/9.
//  Copyright © 2017年 武卓. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    dynamic var name = ""
    dynamic var age = ""
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
