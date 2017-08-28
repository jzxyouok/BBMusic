//
//  HotSearchKeywordModel.swift
//  test
//
//  Created by bb on 17/3/21.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

var hotSearchKeywordModelArray = [HotSearchKeywordModel]()

class HotSearchKeywordModel: NSObject {
    
    var sort:Int = 0
    
    var keyword:String = ""
    
    var jumpurl:String = ""
    
    static let userDefaults = UserDefaults.standard
    
    
    class func setLocalStorage(array: Array<Any>){
        userDefaults.set(array, forKey: "hotSearchKeyword")
        
    }
    
    
    class func getLocalStorage(){
        let x = userDefaults.array(forKey: "hotSearchKeyword")
        print(x?[0])
    }
    

}
