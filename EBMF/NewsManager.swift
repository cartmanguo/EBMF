//
//  NewsManager.swift
//  EBMF
//
//  Created by randy on 16/4/26.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
import Alamofire
enum Platform:String
{
    case PlayStation = "1"
    case XBOX = "2"
}
enum NewsType:Int
{
    case Game = 0
    case Industry = -1
    case PS = -2
    case XBOX = -3
    case EB = -4
}
let imageUrlKey = "acontent"
let colletionNumKey = "collectn"
let contentKey = "content"
let likeNumKey = "goodn"
let nameKey = "game_name"
let titleKey = "title"
let replyNumKey = "replyn"
let videoImageKey = "video_img"
let videoUrlKey = "video_url"
let newsTypeKey = "name_id"
let feedTypeKey = "feed_type"
class NewsManager: NSObject {
    class func fetchNewsFromServer(platform:Platform,completionHandler:(news:[NewsModel])->())
    {
        let ps4 = "http://api.diershoubing.com:5000/feed/class/1/?pn=0&rn=20&src=ios&version=3.2"
        //        let xbox = "http://api.diershoubing.com:5000/feed/class/2/?pn=0&rn=20&src=ios&version=3.2"
        Alamofire.request(
            .GET,
            ps4,
            parameters: ["include_docs": "true"],
            encoding: .URL)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject]
                    else
                {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
                var newsArray = [NewsModel]()
                guard let newsFeed = value["feeds"] as? NSArray
                    else
                {
                    return
                }
                //                print(newsFeed)
                for newsInfo in newsFeed
                {
                    var isVideo = false
                    var videoUrl:String?
                    var imgUrlArray = [String]()
                    let imageUrl = newsInfo[imageUrlKey] as? String
                    if imageUrl!.isUrl()
                    {
                        if imageUrl?.componentsSeparatedByString(",").count == 1
                        {
                            imgUrlArray.append(imageUrl!)
                        }
                        else
                        {
                            imgUrlArray.appendContentsOf(imageUrl!.componentsSeparatedByString(","))
                        }
                    }
                    else
                    {
                        //Video
                        isVideo = true
                        let videoImageUrl = newsInfo[videoImageKey] as? String
                        videoUrl = newsInfo[videoUrlKey] as? String
                        imgUrlArray.append(videoImageUrl!)
                    }
                    var title = ""
                    let newsType = newsInfo[newsTypeKey] as? Int
                    if newsType! == NewsType.Industry.rawValue
                    {
                        title = "游戏新闻"
                    }
                    else if newsType! == NewsType.Game.rawValue
                    {
                        title = (newsInfo[nameKey] as? String)!
                    }
                    else if newsType! == NewsType.PS.rawValue
                    {
                        title = "PS新闻"
                    }
                    else if newsType! == NewsType.XBOX.rawValue
                    {
                        title = "XBOX新闻"
                    }
                    else
                    {
                        title = "二柄"
                    }
                    let content = newsInfo[contentKey] as? String
                    //                    print(imgUrlArray.count)
                    let newsModel = NewsModel(imageUrl: imgUrlArray, videoUrl: videoUrl, content: content, title: title, isVideoContent: isVideo)
                    newsArray.append(newsModel)
                }
                completionHandler(news: newsArray)
                
        }
    }
}
