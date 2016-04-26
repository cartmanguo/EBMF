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
let imageUrlKey = "acontent"
let colletionNumKey = "collectn"
let contentKey = "content"
let likeNumKey = "goodn"
let nameKey = "game_name"
let titleKey = "title"
let replyNumKey = "replyn"
let videoImageKey = "video_img"
let videoUrlKey = "video_url"
class NewsManager: NSObject {
    class func fetchNewsFromServer(platform:Platform,completionHandler:(news:[NewsModel])->())
    {
        let ps4 = "http://api.diershoubing.com:5000/feed/class/1/?pn=0&rn=20&src=ios&version=3.2"
        let xbox = "http://api.diershoubing.com:5000/feed/class/2/?pn=0&rn=20&src=ios&version=3.2"
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
                print(newsFeed)
                for newsInfo in newsFeed
                {
                    newsInfo[imageUrlKey]
                }
                
        }
    }
}
