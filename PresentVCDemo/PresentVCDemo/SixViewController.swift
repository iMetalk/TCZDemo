//
//  SixViewController.swift
//  PresentVCDemo
//
//  Created by WangSuyan on 2017/2/9.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Six"
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.jumpToRootViewController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
