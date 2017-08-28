//
//  Kugou_HotKeywordSearch_Http.swift
//  test
//
//  Created by bb on 17/3/21.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Kugou_HotKeywordSearch_Http: NSObject {
    
    static func hotKeywordSearchRequest(count: Int){
        var str = "http://ioscdn.kugou.com/api/v3/search/hot?plat=2&count=\(count)"
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                if let data = json["data"].dictionary{
                    if let info = data["info"]?.array{
                        if hotSearchKeywordModelArray.count != 0{
                            hotSearchKeywordModelArray.removeAll()
                        }
                        for i in info{
                            let model = HotSearchKeywordModel()
                            model.sort = i["sort"].int!
                            model.keyword = i["keyword"].string!
                            model.jumpurl = i["jumpurl"].string!
                            hotSearchKeywordModelArray.append(model)
                        }
                    }
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "HotKeywordSearchDone"), object: nil)
            }else{
                let errorCode = (error! as NSError).code
                switch errorCode{
                case -1009:
                    showProgressHUD(title: "网络错误")
                    break
                default:
                    break
                }
            }
        })
        task.resume()
    }
    

}
