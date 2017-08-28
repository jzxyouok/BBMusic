//
//  LRCModel.swift
//  test
//
//  Created by bb on 2017/5/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class LrcModel: NSObject {
    
    static var duration:Int = 0
    
    static var id:String = ""
    
    static var accesskey:String = ""
    
    static var lrcText:String = ""
    
    class func currentLrcRequest(keyword: String){
        
        var str = "http://lyrics.kugou.com/search?ver=1&keyword="+keyword+"&duration="+String(duration)+"&hash="+currentSongInfoModel_kugou.songhash+"&man=no&client=mobi"
        
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                if let candidates = json["candidates"].array{
                    guard candidates.count != 0 else{
                        return
                    }
                    id = candidates[0]["id"].string!
                    accesskey = candidates[0]["accesskey"].string!
                    LrcInfoRequest(id: id, accesskey: accesskey)
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

    
    class func LrcInfoRequest(id: String, accesskey:String){
        var str = "http://lyrics.kugou.com/download?ver=1&client=pc&id="+id+"&accesskey="+accesskey+"&fmt=lrc&charset=utf8"
        str = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let session = URLSession.shared
        let request = URLRequest(url: URL(string:str)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if response != nil{
                let json = JSON(data: data!)
                if let content = json["content"].string{
                    let decodedData = Data(base64Encoded: content, options: NSData.Base64DecodingOptions.init(rawValue: 0))
                    let decodedString = NSString(data: decodedData!, encoding: String.Encoding.utf8.rawValue)
                    lrcText = decodedString! as String
                    
                    LrcProcessModel.getLRCContent()
                    
                    //发送歌曲获取完成
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getLrcDone"), object: nil)
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
