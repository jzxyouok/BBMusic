//
//  Kugou_SongListSearch_Http.swift
//  test
//
//  Created by bb on 2017/3/16.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Kugou_SongListSearch_Http: NSObject {
    
    static func songListSearchRequest(keyword: String, page: Int){
        var str = "http://ioscdn.kugou.com/api/v3/search/song?keyword="+keyword+"&page="+String(page)+"&pagesize=30&showtype=10&plat=2&version=8480&tag=1&correct=1&privilege=1&sver=5&tag_aggr=1&tagtype=全部"
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                //print(json)
                if let data = json["data"]["info"].array{
                    if data.count == 0{
                        SongModel.noMoreData = true
                    }else{
                        SongModel.noMoreData = false
                        for i in data{
                            let model = SongListModel1()
                            model.filename = i["filename"].string!
                            model.songname = i["songname"].string!
                            model.othername = i["othername"].string!
                            model.m4afilesize = i["m4afilesize"].int!
                            model.mvhash = i["mvhash"].string!
                            model.filesize = i["filesize"].int!
                            model.bitrate = i["bitrate"].int!
                            model.topic = i["topic"].string!
                            model.isnew = i["isnew"].int!
                            model.duration = i["duration"].int!
                            model.singername = i["singername"].string!
                            model.songhash = i["hash"].string!
                            model.extname = i["extname"].string!
                            model.album_name = i["album_name"].string!
                            //model.group = i["extname"].string!
                            songListModel1Array.append(model)
                        }
                    }
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "SongListSearchDone"), object: nil)
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
