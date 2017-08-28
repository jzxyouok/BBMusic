//
//  SearchResultModel.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Kugou_RealTimeSearch_Http: NSObject {

    static func realTimeSearchRequest(keyword: String){
        var str = "http://ioscdn.kugou.com/new/app/i/search.php?cmd=302&keyword="+keyword
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                if let data = json["data"].array{
                    for i in data{
                        let model = RealTimeSearchModel()
                        model.songcount = i["songcount"].int!
                        model.searchcount = i["searchcount"].int!
                        model.keyword = i["keyword"].string!
                        realTimeSearchModelArray.append(model)
                    }
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "RealTimeSearchDone"), object: nil)
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
