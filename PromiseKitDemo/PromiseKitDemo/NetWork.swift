//
//  NetWork.swift
//  PromiseKitDemo
//
//  Created by WangSuyan on 2017/8/4.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit
import Foundation
import PromiseKit

open class NetWork {
    
    class func postWithParams(params: [String: String]?, urlStr: String) -> Promise<[String: Any]> {
        
        print("Request url: ", urlStr)
        
        let promise = Promise<[String: Any]> { (resolve, reject) in
            
            let url = URL(string: urlStr)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let session: URLSession = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    reject(error)
                } else {
                    
                    do {
                        let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                        let code = dict["code"] as! Int
                        if code == 200 {
                            resolve(dict)
                        } else {
                            let aError = NSError(domain: "Params error", code: 201, userInfo: nil)
                            reject(aError)
                        }
                    } catch {
                        // deal with error
                        reject(error)
                    }
                    
                }
            }
            
            task.resume()
        }
        
        return promise;
    }
}
