//
//  SVideoModel.swift
//  test
//
//  Created by bb on 2017/6/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

struct SVideoHttp_Request {
    
    //当前页码
    static var page:Int = 0
    
    static var noMoreData:Bool = false
    
    static func sVideoSearchRequest(){
        var str = "http://mobilecdngz.kugou.com/api/v5/video/list?plat=2&version=8550&id=0&page=\(page)&pagesize=20&sort=4&short=1"
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                if let data = json["data"].dictionary{
                    guard let info = data["info"]?.array else{
                        return
                    }
                    if data.count == 0{
                        SVideoHttp_Request.noMoreData = true
                    }else{
                        SVideoHttp_Request.noMoreData = false
                        for i in info{
                            var model = SVideoModel()
                            model.description = i["description"].string!
                            model.singername = i["singername"].string!
                            model.useravatar = i["useravatar"].string!
                            model.videoid = i["videoid"].int!
                            model.videoname = i["videoname"].string!
                            model.userid = i["userid"].int!
                            model.userdesc = i["userdesc"].string!
                            model.playcount = i["playcount"].int!
                            model.img = i["img"].string!.replacingOccurrences(of: "{size}", with: "")
                            model.title = i["title"].string!
                            model.comment = i["comment"].int!
                            model.remark = i["remark"].string!
                            model.mvhash = i["mvhash"].string!
                            model.username = i["username"].string!
                            model.publish = i["publish"].string!
                            SVideoModel.sVideoModel.append(model)
                        }
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "SVideoSearchDone"), object: nil)
                    }
                }
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
