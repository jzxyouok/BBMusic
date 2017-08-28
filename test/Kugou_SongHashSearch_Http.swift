//
//  Kugou_SongHashSearch_Http.swift
//  test
//
//  Created by bb on 17/3/18.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class Kugou_SongHashSearch_Http: NSObject {
    
    static func songHashSearchRequest(hash: String){
        var str = "http://m.kugou.com/app/i/getSongInfo.php?hash="+hash+"&cmd=playInfo"
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)

                if let imgUrl = json["imgUrl"].string{
                    currentSongInfoModel_kugou.imgUrl = imgUrl.replacingOccurrences(of: "{size}", with: "400")
                }
                if let url = json["url"].string{
                    currentSongInfoModel_kugou.url = url
                }
                if let topic_url = json["topic_url"].string{
                    currentSongInfoModel_kugou.topic_url = topic_url
                }
                if let error = json["error"].string{
                    currentSongInfoModel_kugou.error = error
                }
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "SongHashSearchDone"), object: nil)
                //播放地址不能为空
                guard currentSongInfoModel_kugou.url != "" || currentSongInfoModel_kugou.error == "" else{
                    return
                }
                //新开线程 下载文件，优先级最低／延时1秒启动
                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    //print(" 启动下载")
                    DownLoadFile.downLoadFile(file_link: currentSongInfoModel_kugou.url, hash: hash, extName: "mp3")
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
