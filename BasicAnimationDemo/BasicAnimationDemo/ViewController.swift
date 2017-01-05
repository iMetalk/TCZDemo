//
//  ViewController.swift
//  BasicAnimationDemo
//
//  Created by WangSuyan on 2017/1/4.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit

private let kViewWidth: CGFloat = 100

class ViewController: UIViewController {
    
    var layerView: UIView!
    var colorLayer: CALayer!
    
    var bezierPath: UIBezierPath!
    var shipLayer: CALayer!
    
    var rotateLayer: CALayer!
    
    var trasitionImageView: UIImageView!
    
    var isHaveChanged: Bool = false
    var tempColor: UIColor = UIColor.blue

    override func viewDidLoad() {
        super.viewDidLoad()

        layerView = UIView(frame: CGRect(x: (view.frame.width - kViewWidth) / 2.0, y: 100, width: kViewWidth, height: kViewWidth))
        layerView.backgroundColor = UIColor.clear
        layerView.layer.cornerRadius = layerView.frame.width / 2.0
        layerView.layer.masksToBounds = true
        layerView.layer.borderWidth = 2.0
        layerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(layerView)
        
        colorLayer = CALayer()
        colorLayer.frame = layerView.bounds
        colorLayer.backgroundColor = UIColor.blue.cgColor
        layerView.layer.addSublayer(colorLayer)
        
        createBirdUI()
        
        createRotateUI()
        
        createTrasitionUI()
    }
    
    func createBirdUI() {
        let startPonint = CGPoint(x: 100, y: 300)
        bezierPath = UIBezierPath()
        bezierPath.move(to: startPonint)
        bezierPath.addCurve(to: CGPoint(x: 300, y: 300), controlPoint1: CGPoint(x: view.frame.midX, y: 500), controlPoint2: CGPoint(x: view.frame.midX, y: 600))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        self.view.layer.addSublayer(shapeLayer)
        
        shipLayer = CALayer()
        shipLayer.frame = CGRect(origin: startPonint, size: CGSize(width: 40, height: 40));
        shipLayer.position = startPonint
        shipLayer.contents = UIImage(named: "bird")?.cgImage
        self.view.layer.addSublayer(shipLayer)
    }
    
    func createRotateUI() {
        rotateLayer = CALayer()
        rotateLayer.frame = CGRect(x: 200, y: 300, width: 80, height: 80)
        rotateLayer.position = CGPoint(x: 200, y: 300)
        rotateLayer.cornerRadius = 80 / 2.0
        rotateLayer.masksToBounds = true
        rotateLayer.borderWidth = 2.0
        rotateLayer.contents = UIImage(named: "bird")?.cgImage
        rotateLayer.borderColor = UIColor.red.cgColor
        self.view.layer.addSublayer(rotateLayer)
    }
    
    func createTrasitionUI() {
        trasitionImageView = UIImageView(frame: CGRect(x: 20, y: view.frame.height - 200 - 20, width: 200, height: 200))
        trasitionImageView.image = UIImage(named: "3")
        view.addSubview(trasitionImageView)
    }
    
    @IBAction func transitionAction(_ sender: Any) {
        trasitionAnimation2()
    }
    
    func trasitionAnimation() {
        let trasition = CATransition()
        // Control animation ways
        trasition.type = kCATransitionFade
        // Control direction
        //        trasition.subtype = kCATransitionFromTop
        let imageName = "\(arc4random() % 4 + 3)"
        trasitionImageView.image = UIImage(named: imageName)
        trasitionImageView.layer.add(trasition, forKey: nil)
    }
    
    func trasitionAnimation2() {
        UIView.transition(with: trasitionImageView, duration: 1.0, options: .transitionCurlUp, animations: {[weak self] in
            let imageName = "\(arc4random() % 4 + 3)"
            if let wself = self{
                wself.trasitionImageView.image = UIImage(named: imageName)
            }
        }) { (isFinish) in
            
        }
    }
    
    
    @IBAction func rotateAction(_ sender: Any) {
        animationRotate2()
    }
    
    func animationRotate() {
        // Must set layer content
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation";
        animation.duration = 1.0
        animation.byValue = M_PI * 2
        rotateLayer.add(animation, forKey: nil)
    }
    
    func animationRotate2() {
        // Rotate
        let animation = CABasicAnimation()
        animation.keyPath = "transform";
        animation.duration = 0.6
        animation.toValue = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
        
        // KeyFrame
        let keyAnimate = CAKeyframeAnimation(keyPath: "backgroundColor")
        keyAnimate.duration = 1.0
        keyAnimate.values = [
            UIColor.red.cgColor,
            UIColor.yellow.cgColor,
            UIColor.purple.cgColor
        ]
        
        // Group
        let groupAnimate = CAAnimationGroup()
        groupAnimate.animations = [animation, keyAnimate]
        groupAnimate.duration = 1.0
        groupAnimate.repeatCount = 100.0
        
        rotateLayer.add(groupAnimate, forKey: nil)
    }
    
    @IBAction func pathAnimate(_ sender: Any) {
        let keyAnimation = CAKeyframeAnimation(keyPath: "position")
        keyAnimation.duration = 3.0
        keyAnimation.repeatCount = 10
        keyAnimation.path = bezierPath.cgPath
        keyAnimation.rotationMode = kCAAnimationRotateAuto
        shipLayer.add(keyAnimation, forKey: nil)
    }
    
    @IBAction func keyframeAction(_ sender: Any) {
        let keyAnimate = CAKeyframeAnimation(keyPath: "backgroundColor")
        keyAnimate.duration = 2.0
        keyAnimate.repeatCount = 100.0
        keyAnimate.values = [
            UIColor.red.cgColor,
            UIColor.yellow.cgColor,
            UIColor.purple.cgColor
        ]
        colorLayer.add(keyAnimate, forKey: nil)
    }
    

    @IBAction func changeColor(_ sender: Any) {
        if isHaveChanged {
            changeColorAnimate(color: UIColor.blue)
        }else{
            changeColorAnimate(color: UIColor.red)
        }
        isHaveChanged = !isHaveChanged
    }
    
    func changeColorAnimate(color: UIColor) {
        tempColor = color
        
        let animate = CABasicAnimation()
        animate.fromValue = colorLayer.backgroundColor
        // You must add this, or you will not chang the color
        animate.toValue = color.cgColor
        animate.duration = 0.55
        animate.keyPath = "backgroundColor"
        animate.delegate = self
        colorLayer.add(animate, forKey: nil)
    }
}


extension ViewController: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            // Disable implicit animation
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.colorLayer.backgroundColor = tempColor.cgColor
            CATransaction.commit()
        }
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
}


