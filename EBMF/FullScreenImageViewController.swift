//
//  FullScreenImageViewController.swift
//  MimicWeixinSport
//
//  Created by randy on 15/8/10.
//  Copyright (c) 2015年 randy. All rights reserved.
//

import UIKit
import Kingfisher
class FullScreenImageViewController: UIViewController,UIScrollViewDelegate,PhotoViewDelegate
{
    var imageView:UIImageView = UIImageView()
    var image:UIImage?
    var scrollView:UIScrollView!
    var imageUrls:[String]?
    var imageViews:[UIImageView] = [UIImageView]()
    var currentIndex:Int = 1
    var pageInfo:PageInfoView?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width * CGFloat((imageUrls?.count)!), scrollView.frame.size.height)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        view.addSubview(scrollView)
        pageInfo = PageInfoView(frame: CGRectMake(0, view.frame.size.height - 100, view.frame.size.width, 30), currentPage: currentIndex, totalPage: imageUrls!.count)
        view.addSubview(pageInfo!)
        self.view.backgroundColor = UIColor.blackColor()
        for (index, url) in imageUrls!.enumerate()
        {
            let photo = EBPhoto()
            photo.imageUrl = url
            let photoView = PhotoView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width * CGFloat(index), 0,CGRectGetWidth(scrollView.bounds),CGRectGetHeight(scrollView.bounds)))
            photoView.photoViewDelegate = self
            photoView.photo = photo
            scrollView.addSubview(photoView)
        }
        scrollView.contentOffset.x = scrollView.frame.size.width * CGFloat(currentIndex)
        pageInfo?.update(Int(scrollView.contentOffset.x / scrollView.frame.size.width)+1)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageInfo?.update(Int(scrollView.contentOffset.x / scrollView.frame.size.width)+1)
    }
    
    func didTapPhotoView(photoView: PhotoView) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
