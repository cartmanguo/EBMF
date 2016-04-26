//
//  EBSegment.swift
//  EBMF
//
//  Created by randy on 16/4/26.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
protocol EBSegmentDelegate {
    func segment(segment:EBSegment, didSelectAtIndex index:Int)
}
class EBSegment: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var delegate:EBSegmentDelegate?
    var titles:[String]?
    var currentIndex = 0
    var menuItemView:UICollectionView?
    init(titles:[String])
    {
        super.init(frame: CGRectZero)
        self.titles = titles
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
//        layout.itemSize = CGSize(width: 35, height: 25)
//        layout.minimumInteritemSpacing = 25
        menuItemView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        menuItemView?.delegate = self
        menuItemView?.dataSource = self
        addSubview(menuItemView!)
        menuItemView?.backgroundColor = UIColor.clearColor()
        menuItemView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        menuItemView?.scrollEnabled = false
    }
    
    override func layoutSubviews() {
        menuItemView?.frame = self.bounds
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 55, height: 25)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width, height: 25))
                textLabel.textAlignment = .Center
//        cell.contentView.backgroundColor = UIColor.grayColor()
//        textLabel.backgroundColor = UIColor.redColor()
        cell.contentView.addSubview(textLabel)
        textLabel.text = titles![indexPath.row]
        if indexPath.row == 0
        {
            textLabel.font = UIFont.boldSystemFontOfSize(17)
            textLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let previousCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: currentIndex, inSection: 0))
        let previousCellLabel = previousCell?.contentView.subviews[0] as? UILabel
        previousCellLabel?.font = UIFont.systemFontOfSize(17)
        UIView.animateWithDuration(0.3, animations: {() in
            previousCellLabel!.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        })
        currentIndex = indexPath.row
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        let label = cell?.contentView.subviews[0] as? UILabel
        label?.font = UIFont.boldSystemFontOfSize(17)
        UIView.animateWithDuration(0.3, animations: {() in
            label!.transform = CGAffineTransformScale(label!.transform, 1.05, 1.05);
        })
        self.delegate?.segment(self, didSelectAtIndex: currentIndex)
    }
    
    func setupButtons()
    {
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
