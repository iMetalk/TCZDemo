//
//  ViewController.swift
//  PresentVCDemo
//
//  Created by WangSuyan on 2017/2/9.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Root"
        
        var isContinue = true
        var count = 0
        while isContinue {
            if count == 10 {
                isContinue = false
            }
            count += 1
            print("count: \(count)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstVC = FirstViewController()
        self.navigationController?.pushViewController(firstVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController{
    
    func jumpToRootViewController() {
        
        /**
         * currentViewController is a UIViewController instance
         * You must ensure currentViewController is a UIViewController
         */
        var currentViewController: UIViewController? = self
        while let currentVC = currentViewController {
            if let nav = currentVC.navigationController {
                nav.popToRootViewController(animated: false)
                let rootViewController = nav.viewControllers.first
                if  let rootVC = rootViewController{
                    if let presentViewController = rootVC.presentingViewController{
                        if presentViewController is UINavigationController {
                            let presentNav = presentViewController as! UINavigationController
                            currentViewController = presentNav.viewControllers.first
                            currentViewController?.dismiss(animated: false, completion: nil)
                        }else{
                            currentViewController = presentViewController
                            presentingViewController?.dismiss(animated: false, completion: nil)
                        }
                    }else{
                        currentViewController = nil
                    }
                }else{
                    currentViewController = nil
                }
            }else{
                currentVC.dismiss(animated: false, completion: nil)
                currentViewController = nil
            }
        }

    }
}

