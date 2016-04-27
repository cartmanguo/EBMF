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

    @IBOutlet weak var newsIcon: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageCollectionView:IndexCollectionView!
    var newModel:NewsModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
        imageCollectionView.backgroundColor = UIColor.whiteColor()
        imageCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
