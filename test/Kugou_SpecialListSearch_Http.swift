//
//  Kugou_SpecialListSearch_Http.swift
//  test
//
//  Created by bb on 2017/3/27.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Kugou_SpecialListSearch_Http: NSObject {
    
    static func specialListSearchRequest(keyword: String, page: Int){
        var str = "http://ioscdn.kugou.com/api/v3/search/special?keyword="+keyword+"&page="+String(page)+"&pagesize=20&plat=2&version=8480&filter=0"
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                print(json)
                if let data = json["data"]["info"].array{
                    if data.count == 0{
                        SpecialModel.noMoreData = true
                    }else{
                        SpecialModel.noMoreData = false
                        for i in data{
                            let model = SpecialListModel()
                            model.specialname = i["specialname"].string!
                            model.nickname = i["nickname"].string!
                            model.publishtime = i["publishtime"].string!
                            model.singername = i["singername"].string!
                            model.intro = i["intro"].string!
                            model.songcount = i["songcount"].int!
                            model.imgurl = i["imgurl"].string!.replacingOccurrences(of: "{size}", with: "")
                            model.verified = i["verified"].int!
                            model.suid = i["suid"].int!
                            model.specialid = i["specialid"].int!
                            model.collectcount = i["collectcount"].int!
                            model.playcount = i["playcount"].int!
                            model.slid = i["slid"].int!
                            specialListModelArray.append(model)
                        }
                    }
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "SpecialListSearchDone"), object: nil)
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
