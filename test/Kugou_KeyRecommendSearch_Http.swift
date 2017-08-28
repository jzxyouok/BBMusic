//
//  Kugou_KeyRecommendSearch_Http.swift
//  test
//
//  Created by bb on 2017/3/21.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Kugou_KeyRecommendSearch_Http: NSObject {

    static func keyRecommendSearchRequest(keyword: String){
        var str = "http://ioscdn.kugou.com/api/v3/search/keyword_recommend?keyword="+keyword
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                //print(json)
                if let data = json["data"]["info"].dictionary{
                    print("有推荐")
                    keywordRecommendModel.isRecommend = true
                    keywordRecommendModel.imgurl = (data["imgurl"]?.string)!
                    keywordRecommendModel.title = (data["title"]?.string)!
                    keywordRecommendModel.type = (data["type"]?.string)!
                    keywordRecommendModel.intro = (data["intro"]?.string)!
                    if let extra = data["extra"]?.dictionary{
                        keywordRecommendModel.jump_url = (extra["jump_url"]?.string)!
                        keywordRecommendModel.id = (extra["id"]?.int)!
                        keywordRecommendModel.has_child = (extra["has_child"]?.int)!
                        keywordRecommendModel.bannerurl = (extra["bannerurl"]?.string)!
                        keywordRecommendModel.is_new = (extra["is_new"]?.int)!
                        keywordRecommendModel.name = (extra["name"]?.string)!
                    }
                }else{
                    print("无推荐")
                    keywordRecommendModel.isRecommend = false
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "KeyRecommendSearchDone"), object: nil)
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
