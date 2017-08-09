//
//  BaseModel.swift
//  Model-Swift
//
//  Created by 田向阳 on 2017/8/9.
//  Copyright © 2017年 田向阳. All rights reserved.
//

import UIKit
import HandyJSON
//import YYModel

enum Gender: String,HandyJSONEnum {
    case Male = "Male"
    case Female = "Female"
}

enum Grade: Int,HandyJSONEnum {
    case One = 1
    case Two = 2
    case Three = 3
}

struct Teacher:HandyJSON {
    var name: String?
    var age: Int?
    var height: Int?
    var gender: Gender?
}

struct Subject:HandyJSON{
    var name: String?
    var id: Int64?
    var credit: Int?
    var lessonPeriod: Int?
}

class Student: BaseModel {
    var id: String?
    var name: String?
    var age: Int?
    var grade: Grade = .One
    var height: Int?
    var gender: Gender?
    var className: String?
    var teacher: Teacher?
    var subject: [Subject]?
    var seat: String?
    var parent: (String, String)?
    
    //转换 字段
    func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.id <-- "id"
        // specify 'parent' field in json parse as following to 'parent' property in object
        mapper <<<
            self.parent <-- TransformOf<(String, String), String>(fromJSON: { (rawString) -> (String, String)? in
                if let parentNames = rawString?.characters.split(separator: "/").map(String.init) {
                    return (parentNames[0], parentNames[1])
                }
                return nil
            }, toJSON: { (tuple) -> String? in
                if let _tuple = tuple {
                    return "\(_tuple.0)/\(_tuple.1)"
                }
                return nil
            })
    }
}

class BaseModel:HandyJSON {
    
    required  init() {}
}
