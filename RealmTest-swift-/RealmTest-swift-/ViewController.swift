//
//  ViewController.swift
//  RealmTest-swift-
//
//  Created by 武卓 on 2017/8/8.
//  Copyright © 2017年 武卓. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listTableView :UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTable() {
        listTableView = UITableView()
        
    }

}

