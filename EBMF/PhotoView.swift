//
//  PhotoView.swift
//  EBMF
//
//  Created by randy on 16/5/9.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
protocol PhotoViewDelegate {
    func didTapPhotoView(photoView:PhotoView)
}

class PhotoView: UIScrollView,UIScrollViewDelegate {
    var imageView:UIImageView?
    var photoViewDelegate:PhotoViewDelegate?
    var photo:EBPhoto?
    {
        didSet
        {
            showImage()
        }
    }
    var pageControl:UIPageControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        imageView = UIImageView()
        imageView?.contentMode = .ScaleAspectFit
        self.addSubview(imageView!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoView.dismiss))
        self.addGestureRecognizer(tap)
        
    }
    
    func showImage()
    {
        imageView?.kf_setImageWithURL(NSURL(string: (photo?.imageUrl!)!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: {(image,err,cache,url) in
            if err == nil
            {
                self.resetImageViewFrame(image: image!)
                self.photo?.image = image
            }
        })
    }
    
    func resetImageViewFrame(image image:UIImage)
    {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let imageScale = min(1,width/imageWidth)
        let imageFrame = CGRectMake(0, max(0, (height - imageHeight * imageScale)/2), width, imageScale * imageHeight)
        self.maximumZoomScale = 1
        self.minimumZoomScale = imageScale
        self.zoomScale = imageScale
        print(imageScale)
        self.contentSize = CGSizeMake(CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame))
        imageView?.frame = imageFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        var insetY = (CGRectGetHeight(self.bounds) - CGRectGetHeight(imageView!.frame))/2;
        insetY = max(insetY, 0.0);
        if (abs(imageView!.frame.origin.y - insetY) > 0.5) {
            UIView.animateWithDuration(0.2, animations: {() in
                var imageViewFrame = self.imageView!.frame;
                imageViewFrame = CGRectMake(imageViewFrame.origin.x, insetY, imageViewFrame.size.width, imageViewFrame.size.height);
                self.imageView!.frame = imageViewFrame;
            });
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss()
    {
        self.photoViewDelegate?.didTapPhotoView(self)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
