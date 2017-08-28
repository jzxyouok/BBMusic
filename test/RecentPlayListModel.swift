//
//  RecentPlayModel.swift
//  test
//
//  Created by bb on 2017/2/19.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

var recentPlayListModelArray = [SongListModel1]()

class RecentPlayListModel: NSObject {
    
    var imgUrl:String = ""
    
    var filename:String = ""
    
    var songname:String = ""
    
    var othername:String = ""
    
    var m4afilesize:Int = 0
    
    var mvhash:String = ""
    
    var filesize:Int = 0
    
    var bitrate:Int = 0
    
    var topic:String = ""
    
    var isnew:Int = 0
    
    var duration:Int = 0
    
    var singername:String = ""
    
    var songhash:String = ""
    
    var extname:String = ""
    
    var album_name:String = ""
    
    var group = [JSON]()
}
