//
//  SQLite.swift
//  test
//
//  Created by bb on 2017/2/18.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SQLite


class CurrentPlaySQLite: NSObject {
    
    static var db:Connection! = nil
    static let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static let lastPlayRecord = Table("lastPlayRecord")
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
                try db.run(lastPlayRecord.create(ifNotExists: true, block: { (table) in
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
        do{
            let count = try db.scalar(lastPlayRecord.count)
            if count < 1{
                let insert = lastPlayRecord.insert(songhash <- hash, songname <- name, othername <- other,url <- file_link, imageUrl <- image, singername <- artist, album_name <- albums, isCached <- cache)
                do{
                    try db.run(insert)
                }catch{
                    print("插入失败")
                }
            }else{
                print("超出1条，不再执行插入")
                update(hash: hash, name: name, other: other, file_link: file_link, image: image, artist: artist, albums: albums, cache: cache)
            }
        }catch{
            
        }
    }
    
    
    class func prepare(){
        do{
            let records = try db.prepare(self.lastPlayRecord)
            for record in records{
                currentSongInfoModel_kugou.songhash = record[songhash]
                currentSongInfoModel_kugou.url = record[url]
                currentSongInfoModel_kugou.songname = record[songname]
                currentSongInfoModel_kugou.othername = record[othername]
                currentSongInfoModel_kugou.imgUrl = record[imageUrl]
                currentSongInfoModel_kugou.singername = record[singername]
                currentSongInfoModel_kugou.album_name = record[album_name]
                currentSongInfoModel_kugou.isCached = record[isCached]
            }
        }catch{
            print("查询失败")
        }
    }
    
    
    class func update(hash:String,name:String,other:String,file_link:String,image:String,artist:String,albums:String, cache:Bool){
        let update = lastPlayRecord.filter(id == 1)
        let new = update.update(songhash <- hash, songname <- name, othername <- other, url <- file_link, imageUrl <- image, singername <- artist, album_name <- albums, isCached <- cache)
        do{
            try db.run(new)
        }catch{
            print("更新失败")
        }
    }
    
    
    class func delete(hash: String){
        let delete = lastPlayRecord.filter(songhash == hash).delete()
        do{
            try db.run(delete)
        }catch{
            print("删除失败")
        }
    }
    

}
