//
//  PageInfoView.swift
//  EBMF
//
//  Created by randy on 16/5/9.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class PageInfoView: UIView {
    var currentPage:Int = 0
    var totalPage:Int = 0
    var infoLabel:UILabel?
    init(frame:CGRect,currentPage:Int,totalPage:Int)
    {
        super.init(frame: frame)
        self.currentPage = currentPage
        self.totalPage = totalPage
        infoLabel = UILabel(frame: self.bounds)
        infoLabel?.font = UIFont.systemFontOfSize(15)
        infoLabel?.textColor = UIColor.whiteColor()
        infoLabel?.textAlignment = .Center
        infoLabel?.text = String(format: "%d/%d", arguments: [currentPage,totalPage])
        addSubview(infoLabel!)

    }
    
    func update(currentPage:Int)
    {
        self.currentPage = currentPage
        infoLabel?.text = String(format: "%d/%d", arguments: [currentPage,totalPage])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        infoLabel = UILabel(frame: frame)
//        infoLabel?.font = UIFont.systemFontOfSize(15)
//        infoLabel?.textColor = UIColor.whiteColor()
//        infoLabel?.text = String(format: "%d/%d", arguments: [currentPage,totalPage])
//        addSubview(infoLabel!)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
