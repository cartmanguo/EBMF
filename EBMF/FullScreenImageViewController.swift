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
    var visiblePhotoViews = NSMutableSet()
    var reusablePhotoViews = NSMutableSet()
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
        scrollView.contentOffset.x = scrollView.frame.size.width * CGFloat(currentIndex)

        showPhotoViews()

//        for (index, url) in imageUrls!.enumerate()
//        {
//            let photo = EBPhoto()
//            photo.imageUrl = url
//            let photoView = PhotoView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width * CGFloat(index), 0,CGRectGetWidth(scrollView.bounds),CGRectGetHeight(scrollView.bounds)))
//            photoView.photoViewDelegate = self
//            photoView.photo = photo
//            scrollView.addSubview(photoView)
//        }
        
    }
    
    func showPhotoViews()
    {
        let visibleBounds = scrollView.bounds
        var firstIndex = Int(floor((CGRectGetMinX(visibleBounds)) / CGRectGetWidth(visibleBounds)))
        var lastIndex  = Int(floor((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds)))
//        print(firstIndex,lastIndex)
        if (firstIndex < 0)
        {
            firstIndex = 0
        }
        if (firstIndex >= imageUrls!.count)
        {
            firstIndex = imageUrls!.count-1
        }
        if (lastIndex < 0)
        {
            lastIndex = 0
        }
        if (lastIndex >= imageUrls!.count)
        {
            lastIndex = imageUrls!.count-1
        }
        var photoViewIndex = 0
        for photoView in visiblePhotoViews
        {
            photoViewIndex = photoView.tag - 1000
            if photoViewIndex < firstIndex || photoViewIndex > lastIndex
            {
                reusablePhotoViews.addObject(photoView)
                photoView.removeFromSuperview()
            }
        }
        visiblePhotoViews.minusSet(reusablePhotoViews as Set<NSObject>)
        while reusablePhotoViews.count > 2
        {
            reusablePhotoViews.removeObject(reusablePhotoViews.anyObject()!)
        }
        for index in firstIndex ..< lastIndex+1
        {
            if isViewShowingAtIndex(index: index) == false
            {
                print("show",index)
                showViewAtIndex(index: index)
            }
        }
    }
    
    func dequeReusableView()->PhotoView?
    {
        let photoView = reusablePhotoViews.anyObject() as? PhotoView
        if photoView != nil
        {
            reusablePhotoViews.removeObject(photoView!)
        }
        return photoView
    }
    
    func isViewShowingAtIndex(index index:Int)->Bool
    {
        for photoView in visiblePhotoViews
        {
            if photoView.tag - 1000 == index
            {
                return true
            }
        }
        return false
    }
    
    func showViewAtIndex(index index:Int)
    {
        var photoView = dequeReusableView()
        if photoView == nil
        {
            print("create")
            photoView = PhotoView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width * CGFloat(index), 0,CGRectGetWidth(scrollView.bounds),CGRectGetHeight(scrollView.bounds)))
        }
        let photo = EBPhoto()
        photo.imageUrl = imageUrls![index]
        photoView!.photoViewDelegate = self
        photoView!.photo = photo
        photoView!.tag = 1000 + index
        scrollView.addSubview(photoView!)
        photoView?.frame.origin.x = UIScreen.mainScreen().bounds.size.width * CGFloat(index)
        visiblePhotoViews.addObject(photoView!)

        pageInfo?.update(Int(scrollView.contentOffset.x / scrollView.frame.size.width)+1)
        loadNearByImageAroundIndex(index: index)
    }
    
    func loadNearByImageAroundIndex(index index:Int)
    {
        if index > 0
        {
            let url = imageUrls![index - 1]
            KingfisherManager.sharedManager.downloader.downloadImageWithURL(NSURL(string: url)!, progressBlock: {(receivedSize,totalSize) in
                }, completionHandler: {(image,error,url,data) in
            })
        }
        if index < imageUrls!.count - 1
        {
            let url = imageUrls![index + 1]
            KingfisherManager.sharedManager.downloader.downloadImageWithURL(NSURL(string: url)!, progressBlock: {(receivedSize,totalSize) in
                }, completionHandler: {(image,error,url,data) in
            })
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageInfo?.update(Int(scrollView.contentOffset.x / scrollView.frame.size.width)+1)
        showPhotoViews()
//        print(visiblePhotoViews.count)
    }
    
    func didTapPhotoView(photoView: PhotoView) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
