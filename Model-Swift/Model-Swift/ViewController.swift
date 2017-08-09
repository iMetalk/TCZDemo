//
//  ViewController.swift
//  Model-Swift
//
//  Created by 田向阳 on 2017/8/9.
//  Copyright © 2017年 田向阳. All rights reserved.
//

import UIKit
import HandyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonString = "{\"id\":\"77544\",\"name\":\"Tom Li\",\"age\":18,\"grade\":2,\"height\":180,\"gender\":\"Male\",\"className\":\"A\",\"teacher\":{\"name\":\"Lucy He\",\"age\":28,\"height\":172,\"gender\":\"Female\",},\"subject\":[{\"name\":\"math\",\"id\":18000324583,\"credit\":4,\"lessonPeriod\":48},{\"name\":\"computer\",\"id\":18000324584,\"credit\":8,\"lessonPeriod\":64}],\"seat\":\"4-3-23\"}"
        
        let model = BaseModel.deserialize(from: jsonString)
        
        print(model.debugDescription)
    }

 
}

