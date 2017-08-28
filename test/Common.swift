//
//  Common.swift
//  test
//
//  Created by bb on 2017/6/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

struct Common {
    
    //返回时间格式20:20
    static func stringFromTimeInterval(interval: Double) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //播放次数（保留两位小数）
    static func playCount(count: Double)->String{
        var playCount = ""
        if count < 10000{
            playCount = String(format: "%.0f", count)
        }else if count >= 10000 && count < 100000000{
            playCount = String(format: "%.1f", count/10000)+"万"
        }else{
            playCount = String(format: "%.1f", count/100000000)+"亿"
        }
        return playCount
    }
    
    //检测app版本号
    static func versionCheck() -> String{
        let infoDictionary = Bundle.main.infoDictionary
        let majorVersion = infoDictionary?["CFBundleShortVersionString"]
        return majorVersion as! String
    }
    
    static func getCurrentDate() -> DateComponents{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day], from: date)
        return components
    }
    

}
