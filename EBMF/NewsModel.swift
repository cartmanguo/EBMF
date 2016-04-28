//
//  NewsModel.swift
//  EBMF
//
//  Created by randy on 16/4/26.
//  Copyright © 2016年 randy. All rights reserved.
//

import Foundation
import UIKit
struct NewsModel
{
    var imageUrl:[String]?
//    var videoUrl:String?
//    var videoImageUrl:String?
    var content:String?
    var title:String?
//    var shareContent:String?//分享时的文本
//    var shareTitle:String?
//    var shareUrl:String?
//    var editorName:String?
//    var isVideoContent:Bool = false
    func cellHeight()->CGFloat
    {
        //256和109是在xib中的高度，算出实际collectionView的高度后，减去109加上实际高度
        let collectionViewSize = UIScreen.mainScreen().bounds.size.width * 19/55 + UIScreen.mainScreen().bounds.size.width * 19/55 - 25 - UIScreen.mainScreen().bounds.size.width * 19/55
        let contentTextSize = (self.content! as NSString).boundingRectWithSize(CGSize(width: UIScreen.mainScreen().bounds.size.width - 8, height: 0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil)
        return contentTextSize.height + 256-18 - 109 + collectionViewSize
    }

}