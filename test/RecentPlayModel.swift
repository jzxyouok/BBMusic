//
//  RecentPlayMaxCountModel.swift
//  test
//
//  Created by bb on 17/3/28.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class RecentPlayModel: NSObject {
    
    static var countSetting = [("0首",0),("10首",10),("20首",20),("30首",30),("40首",40),("50首",50),("60首",60),("70首",70),("80首",80),("90首",90),("100首",100),("110首",110),("120首",120),("130首",130),("140首",140),("150首",150),("160首",160),("170首",170),("180首",180),("190首",190),("200首",200)]
    
    
    //清空所有播放记录
    class func clearAllRecentPlayRecord(){
        BBCacheTool.clearCache()
        CurrentPlaySQLite.delete(hash: currentSongInfoModel_kugou.songhash)
        //遍历所有播放记录，判断是否存在本地缓存文件
        for i in recentPlayListModelArray{
            let hash = i.songhash
            //清空本地所有播放记录 SQL
            RecentPlaySQLite.delete(hash: hash)
            recentPlayListModelArray.removeAll()
        }
    }

}
