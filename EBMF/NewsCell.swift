//
//  NewsCell.swift
//  EBMF
//
//  Created by randy on 16/4/27.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newsIcon: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageCollectionView:IndexCollectionView!
    var newModel:NewsModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollectionView.removeConstraint(heightConstraint)
        contentLabel.numberOfLines = 0
        imageCollectionView.backgroundColor = UIColor.whiteColor()
        imageCollectionView.registerNib(UINib(nibName: "ImageCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "cell")
        self.addConstraint(NSLayoutConstraint(item: imageCollectionView, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 19/55, constant: UIScreen.mainScreen().bounds.size.width * 19/55 - 25 - UIScreen.mainScreen().bounds.size.width * 19/55))
//        heightConstraint.constant = UIScreen.mainScreen().bounds.size.width * 19/55 + 84 - UIScreen.mainScreen().bounds.size.width * 19/55
        layoutIfNeeded()

        // Initialization code
    }
    
    func setup(newsModel:NewsModel)
    {
        newsTitleLabel.text = newsModel.title
        contentLabel.text = newsModel.content
        self.newModel = newsModel
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
