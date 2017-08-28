//
//  SearchRecordModel.swift
//  test
//
//  Created by bb on 2017/1/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

let searchRecordModel = SearchRecordModel()

class SearchRecordModel: NSObject {
    
    static var h:CGFloat = 0
    
    var titleArray = ["热门搜索", "搜索历史"]
    
    var recordArray = [String]()
    
    var currentKeyword:String = ""
    
    var searchType:Int = 0
    //数据持久化存储
    var userDefault = UserDefaults.standard
    
    
    //添加搜索记录方法
    func addKeywordToArray(){
        
        var localStorageDictionar = userDefault.dictionaryRepresentation()
        if localStorageDictionar["recordArray"] != nil{
            let localStorageRecordArray = userDefault.array(forKey: "recordArray")
            //如果本地存储已存在，则从本地获取
            if localStorageRecordArray?.count != 0{
                recordArray = localStorageRecordArray as! [String]
            }
        }
        //若新值已存在，则删除对应位置的值，然后再插入此新值
        for (index,value) in recordArray.enumerated(){
            if currentKeyword == value{
                //print("当前已存在的值为++\(value)")
                recordArray.remove(at: index)
            }
        }
        //从后往前插入数据
        recordArray.insert(currentKeyword, at: 0)
        //最多保留10条记录
        if recordArray.count > 10{
            recordArray.removeLast()
            print("大于10，删除数组第一位")
        }
        userDefault.setValue(recordArray, forKey: "recordArray")
        //数据持久化存储
        userDefault.synchronize()
    }
    

    
    //删除搜索记录方法（单条／全部）
    func delectLocalStorageSearchRecord(index: Int){
        var localStorageDictionar = userDefault.dictionaryRepresentation()
        if localStorageDictionar["recordArray"] != nil{
            let localStorageRecordArray = userDefault.array(forKey: "recordArray")
            if localStorageRecordArray?.count != 0{
                recordArray = localStorageRecordArray as! [String]
                if index == 10001{
                    //清空所有记录
                    recordArray.removeAll()
                }else{
                    //删除单条搜索记录方法
                    recordArray.remove(at: index)
                }
                userDefault.setValue(recordArray, forKey: "recordArray")
                userDefault.synchronize()
            }
        }
    }
    
    

}
