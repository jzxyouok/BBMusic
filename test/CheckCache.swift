//
//  CheckCacheAndPlay.swift
//  test
//
//  Created by bb on 2017/2/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class CheckCache: NSObject {
    
    //获取Document目录
    static let documentsDirectory:NSString = NSHomeDirectory() as NSString
    //创建文件管理器
    static let fileManager = FileManager.default
    
    class func isCached(hash:String) -> Dictionary<String,Any> {
        
        //检测本地缓存
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let songFilePath = paths[0]+"/\(hash).mp3"
        var isCached:Bool = false
        
        if self.fileManager.fileExists(atPath: songFilePath){
            //print("文件已经存在!路径为:++\(songFilePath)")
            isCached = true
        }else{
            isCached = false
            //print("文件未缓存,开始请求网络")
        }
        return ["songFilePath":songFilePath, "isCached":isCached]
    }
    
}
