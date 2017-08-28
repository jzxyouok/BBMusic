//
//  dddd.swift
//  test
//
//  Created by bb on 2017/5/4.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class BBCacheTool: NSObject {
    // 计算缓存大小
    static var cacheSize: String{
        get{
            let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let fileManager = FileManager.default
            
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExists(atPath: basePath!){
                    let childrenPath = fileManager.subpaths(atPath: basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.appendingFormat("/").appendingFormat(path)
                            do{
                                let attr = try fileManager.attributesOfItem(atPath: childPath)
                                let fileSize = attr[FileAttributeKey.size] as! Float
                                total += fileSize
                            }catch _{
                                
                            }
                        }
                    }
                }
                return total
            }
            let totalCache = caculateCache()
            return NSString(format: "%.0f", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    // 清除缓存
    class func clearCache(){
        //var result = true
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: basePath!){
            let childrenPath = fileManager.subpaths(atPath: basePath!)
            for childPath in childrenPath!{
                let cachePath = basePath?.appendingFormat("/").appendingFormat(childPath)
                do{
                    try fileManager.removeItem(atPath: cachePath!)
                }catch _{
                    //result = false
                }
            }
        }
        //return result
    }
}
