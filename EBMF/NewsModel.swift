//
//  NewsModel.swift
//  EBMF
//
//  Created by randy on 16/4/26.
//  Copyright © 2016年 randy. All rights reserved.
//

import Foundation
struct NewsModel
{
    var imageUrl:String?
    var videoUrl:String?
    var videoImageUrl:String?
    var content:String?
    var shareContent:String?//分享时的文本
    var shareTitle:String?
    var shareUrl:String?
    var editorName:String?
    var isVideoContent:Bool = false
}