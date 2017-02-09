//
//  ThirdViewController.swift
//  PresentVCDemo
//
//  Created by WangSuyan on 2017/2/9.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Third"
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("self")
        print(self)
        
        print("viewControllers")
        print(self.navigationController?.viewControllers ?? "NULL")
        
        print("viewControllers first")
        print(self.navigationController?.viewControllers.first ?? "NULL")
        
        let firstVC = self.navigationController?.viewControllers.first
        let firstNav = firstVC?.presentingViewController as! UINavigationController
        print("firstVC presenting")
        print(firstVC?.presentingViewController ?? "NULL")
        
        print("firstNav presenting")
        print(firstNav.presentingViewController ?? "NULL")
        
        print("firstVC viewControllers")
        print(firstNav.viewControllers)
        
        
        let fourVC = FourViewController()
        self.navigationController?.pushViewController(fourVC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
