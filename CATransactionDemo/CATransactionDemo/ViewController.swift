//
//  ViewController.swift
//  CATransactionDemo
//
//  Created by WangSuyan on 2017/1/4.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var layerView: UIView!
    var colorLayer: CALayer!
    var autoView: UIView!
    
    var isHaveChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layerView = UIView(frame: CGRect(x: 30, y: 100, width: 280, height: 280))
        self.view.addSubview(layerView)
        
        autoView = UIView(frame: CGRect(x: 30, y: layerView.frame.maxY + 10, width: layerView.frame.width, height: layerView.frame.height))
        autoView.layer.backgroundColor = UIColor.blue.cgColor
        self.view.addSubview(autoView)
        
        colorLayer = CALayer()
        colorLayer.frame = layerView.bounds
        colorLayer.backgroundColor = UIColor.blue.cgColor
        
        layerView.layer.addSublayer(colorLayer)
        
    }

    @IBAction func changeColorAction(_ sender: Any) {
        // 隐式动画
        if isHaveChanged {
            colorLayer.backgroundColor = UIColor.blue.cgColor
        }else{
            colorLayer.backgroundColor = UIColor.yellow.cgColor
        }
        isHaveChanged = !isHaveChanged
        
    }
    
    @IBAction func changeColorCA(_ sender: Any) {
        // 显示动画
        CATransaction.begin()
        CATransaction.setAnimationDuration(2.0)
        CATransaction.setCompletionBlock { [weak self] in
            print("Animation complete")
            if let weSelf = self{
                print(weSelf.colorLayer)
                
                var transform = weSelf.colorLayer.affineTransform()
                transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                weSelf.colorLayer.setAffineTransform(transform)
            }
            
        }
        
        if isHaveChanged {
            colorLayer.backgroundColor = UIColor.blue.cgColor
        }else{
            colorLayer.backgroundColor = UIColor.yellow.cgColor
        }
        isHaveChanged = !isHaveChanged
        
        CATransaction.commit()
    }
    
    @IBAction func autoChangeColor(_ sender: Any) {
        // 直接改变View本身layer的属性，动画无
        
        CATransaction.begin()
        
        if isHaveChanged {
            autoView.layer.backgroundColor = UIColor.blue.cgColor
        }else{
            autoView.layer.backgroundColor = UIColor.yellow.cgColor
        }
        isHaveChanged = !isHaveChanged
        
        CATransaction.commit()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

