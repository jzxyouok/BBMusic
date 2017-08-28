//
//  Streamer.swift
//  test
//
//  Created by bb on 2017/2/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import StreamingKit

class Streamer: NSObject {
    
    var player:STKAudioPlayer = STKAudioPlayer()

    /// 使用全局变量创建单例
    static let shareInstance = Streamer()
    
    private  override init(){}
    
}
