//
//  DownLoadFile.swift
//  test
//
//  Created by bb on 2017/1/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class DownLoadFile: NSObject, URLSessionDownloadDelegate {
    
    static var extName:String = ""
    
    static var songHash:String = ""
    //任务对列数组
    static var taskArray = [URLSessionDownloadTask]()
    
    class func downLoadFile(file_link:String, hash:String, extName:String){
        
        self.songHash = hash
        
        self.extName = extName
        
        //下载地址
        let url = URL(string: file_link)
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config, delegate: DownLoadFile().self, delegateQueue: OperationQueue.current)
        let downloadTask = session.downloadTask(with: url!)
        downloadTask.resume()
        taskArray.append(downloadTask)
    }
    
    //下载完成
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let locationPath = location.path
        //拷贝到用户目录（文件名：songid 后缀名：extName）
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let path = paths[0]+"/\(DownLoadFile.songHash).\(DownLoadFile.extName)"
        try? FileManager.default.moveItem(atPath: locationPath, toPath: path)
        //下载完成发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downLoadFileDone"), object: nil)
        downloadTask.cancel()
        //清空任务对列数组
        DownLoadFile.taskArray.removeAll()
    }
    
    //下载进度
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //print("下载速度：\(bytesWritten)++已下载：\(totalBytesWritten)++共：\(totalBytesExpectedToWrite)")
        if (totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown) {
            currentSongInfoModel_kugou.cacheProgress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CacheProgress"), object: nil)
            
            //单任务下载，前面开启的下载若未完成，则取消任务
            if DownLoadFile.taskArray.count > 1{
                for (index,task) in DownLoadFile.taskArray.enumerated(){
                    if index != DownLoadFile.taskArray.count - 1{
                        if totalBytesExpectedToWrite != totalBytesWritten{
                            task.cancel()
                        }
                    }
                }
            }
        }
        
    }
    
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("请求完成了？？\(session)")
    }
    //下载中断（网络中断等）
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        task.cancel()
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("请求无效？？\(String(describing: error))")
    }
    
    
    
}
