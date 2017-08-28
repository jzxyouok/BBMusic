//
//  SQLite.swift
//  test
//
//  Created by bb on 2017/2/18.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SQLite


class RecentPlaySQLite: NSObject {
    
    static var db:Connection! = nil
    static let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static let recentPlay = Table("recentPlay")
    static let id = Expression<Int64>("id")
    
    static let url = Expression<String>("url")
    static let imageUrl = Expression<String>("imageUrl")
    
    static let songhash = Expression<String>("songhash")
    static let songname = Expression<String>("songname")
    static let othername = Expression<String>("othername")
    static let singername = Expression<String>("singername")
    static let album_name = Expression<String>("album_name")
    static let isCached = Expression<Bool>("isCached")
    
    class func creat(){
        
        do{
            db = try Connection("\(path)/db.sqlite3")
            do{
                try db.run(recentPlay.create(ifNotExists: true, block: { (table) in
                    table.column(id, primaryKey: true)
                    
                    table.column(url)
                    table.column(imageUrl)
                    
                    table.column(songhash)
                    table.column(songname)
                    table.column(othername)
                    table.column(singername)
                    table.column(album_name)
                    table.column(isCached)
                }))
            }catch{
                print("创建表失败")
            }
        }catch{
            print("链接数据库文件失败")
        }
        
    }
    
    
    class func insert(hash:String,name:String,other:String,file_link:String,image:String,artist:String,albums:String, cache:Bool){
        //任何一个值为空均不执行插入数据
        if hash == "" || name == "" || artist == ""{
            return
        }else{
            for song in recentPlayListModelArray{
                if hash == song.songhash{
                    return
                }
            }
            print("未播放过了，需要保存本地记录")
            let insert = recentPlay.insert(songhash <- hash, songname <- name, othername <- other,url <- file_link, imageUrl <- image, singername <- artist, album_name <- albums, isCached <- cache)
            do{
                try db.run(insert)
            }catch{
                print("插入失败")
            }
        }
    }
    
    
    class func prepare(){
        do{
            if recentPlayListModelArray.count != 0{
                recentPlayListModelArray.removeAll()
            }
            let records = try db.prepare(self.recentPlay)
            for record in records{
                let model = SongListModel1()
                model.imgUrl = record[imageUrl]
                model.songhash = record[songhash]
                model.songname = record[songname]
                model.othername = record[othername]
                model.singername = record[singername]
                model.album_name = record[album_name]
                recentPlayListModelArray.append(model)
            }
        }catch{
            print("查询失败")
        }
    }
    
    
    class func update(hash:String,name:String,other:String,file_link:String,image:String,artist:String,albums:String, cache:Bool){
        let update = recentPlay.filter(songhash == hash)
        let new = update.update(songhash <- hash, songname <- name, othername <- other, url <- file_link, imageUrl <- image, singername <- artist, album_name <- albums, isCached <- cache)
        do{
            try db.run(new)
        }catch{
            print("更新失败")
        }
    }
    
    
    class func delete(hash: String){
        let delete = recentPlay.filter(songhash == hash).delete()
        do{
            try db.run(delete)
        }catch{
            print("删除失败")
        }
    }
    
    
}
