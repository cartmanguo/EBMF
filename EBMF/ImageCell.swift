//
//  ImageCell.swift
//  EBMF
//
//  Created by randy on 16/4/28.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        layoutIfNeeded()
    }
}
