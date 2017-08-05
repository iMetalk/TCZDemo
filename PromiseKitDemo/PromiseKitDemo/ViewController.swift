//
//  ViewController.swift
//  PromiseKitDemo
//
//  Created by WangSuyan on 2017/8/4.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit
import PromiseKit

/**
 有一下场景：
 
 先登录（login），登录成功后，同步联系人列表（contact）, 获取动态消息 (trend)
 
 login(userId) -> contact(contacts) -> trend(trends)
 
 */

private let loginUrl = "http://192.168.199.140:3000/api/login/login"
private let contactUrl = "http://192.168.199.140:3000/api/login/contactList"
private let trendUrl = "http://192.168.199.140:3000/api/login/trendList"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "动态列表"

        requestJoin()
    
    }
    
    func requestJoin() {
        let logPormise = NetWork.postWithParams(params: nil, urlStr: loginUrl)
        let contactPormise = NetWork.postWithParams(params: nil, urlStr: contactUrl)
        let trendPromise = NetWork.postWithParams(params: nil, urlStr: trendUrl)
        
        let resultPromise = join([logPormise, contactPormise])
        
        resultPromise.then { (results) -> Promise<[String: Any]> in
            print(results)
            return trendPromise
            
            }.then { (trends) -> Promise<Any> in
                print(trends)
                return Promise(value: "Success")
            }.catch { (error) in
                print(error)
        }
    }

    
    func requestAlways() {
        let logPormise = NetWork.postWithParams(params: nil, urlStr: loginUrl)
        logPormise.then { (results) in
            print(results)
            
        }.always(execute: { 
            print("always")
        })
        .catch { (error) in
            print(error)
        }
    }
    
    func requestRace() {
        let logPormise = NetWork.postWithParams(params: nil, urlStr: loginUrl)
        let contactPormise = NetWork.postWithParams(params: nil, urlStr: contactUrl)
        let trendPromise = NetWork.postWithParams(params: nil, urlStr: trendUrl)
        
        let resultPromise = race(promises: [logPormise, contactPormise])
        
        resultPromise.then { (results) -> Promise<[String: Any]> in
            print(results)
            return trendPromise
            
            }.then { (trends) -> Promise<Any> in
                print(trends)
                return Promise(value: "Success")
            }.catch { (error) in
                print(error)
        }
    }
    
    func requestWhen() {
        let logPormise = NetWork.postWithParams(params: nil, urlStr: loginUrl)
        let contactPormise = NetWork.postWithParams(params: nil, urlStr: contactUrl)
        let trendPromise = NetWork.postWithParams(params: nil, urlStr: trendUrl)
        
        let resultPromise = when(resolved: [logPormise, contactPormise])
        
        resultPromise.then { (results) -> Promise<[String: Any]> in
            print(results)
            return trendPromise
            
        }.then { (trends) -> Promise<Any> in
            print(trends)
            return Promise(value: "Success")
        }.catch { (error) in
            print(error)
        }
    }
    
    func request() {
        /**
         Promise 的状态一旦改变后将不会再改变
         */
        let logPormise = NetWork.postWithParams(params: nil, urlStr: loginUrl)

        logPormise.then { (result) -> Promise<[String: Any]> in
            print("Login success: ", result)
            return NetWork.postWithParams(params: nil, urlStr: contactUrl)
            
            }.then { (result) -> Promise<[String: Any]> in

                print("Query contacts success: ", result)
                return NetWork.postWithParams(params: nil, urlStr: trendUrl)
                
            }.then { result in
                print("Query trends success: ", result)
                
            }.catch { error in
                /**
                 如果异步操作抛出错误，状态就会变为Rejected，就会调用catch方法指定的回调函数，处理这个错误。
                 logPormise，contactPormise 和 trendPormise 中的任何一个 Promise 抛出异常，都
                 将会被捕获
                 */
                print("Network error:", error)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        title = "正在登录..."
        request()
    }

}

