//
//  HomeViewController.swift
//  EBMF
//
//  Created by randy on 16/4/22.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,EBSegmentDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var newsListView:UITableView!
    var newsArray:[NewsModel] = [NewsModel]()
    let leftMargin:CGFloat = 8
    let space:CGFloat = 8
    let rightMargin:CGFloat = 42
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileButton = UIBarButtonItem(title: "P", style: .Plain, target: self, action: #selector(HomeViewController.showProfile))
        navigationItem.leftBarButtonItem = profileButton
        let messageButton = UIBarButtonItem(title: "M", style: .Plain, target: self, action: #selector(HomeViewController.messages))
        navigationItem.rightBarButtonItem = messageButton
        newsListView = UITableView(frame: view.bounds, style: .Plain)
        view.addSubview(newsListView)
        newsListView.dataSource = self
        newsListView.delegate = self
        newsListView.backgroundColor = UIColor.lightGrayColor()
        newsListView.registerNib(UINib(nibName: "NewsCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "newscell")
        newsListView.separatorStyle = .None
        let segment = EBSegment(titles: ["PS","XBOX","在玩"])
        segment.delegate = self
        segment.frame = CGRectMake(0, 0, 185, 25)
        navigationItem.titleView = segment
        retrieveNews()
        // Do any additional setup after loading the view.
    }
    
    func retrieveNews() {
        let queue = dispatch_queue_create("news_queue", DISPATCH_QUEUE_CONCURRENT)
        dispatch_async(queue, {() in
            NewsManager.fetchNewsFromServer(.PlayStation, completionHandler: {(news) in
                self.newsArray = news
                self.newsListView.reloadData()
            })
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newscell") as? NewsCell
        cell?.selectionStyle = .None
        let news = newsArray[indexPath.row]
        cell?.setup(news)
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let newsCell = cell as! NewsCell
        newsCell.imageCollectionView.delegate = self
        newsCell.imageCollectionView.dataSource = self
        newsCell.imageCollectionView.reloadData()
        newsCell.imageCollectionView.indexPath = indexPath
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let news = newsArray[indexPath.row]
        return news.cellHeight()
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
//        return header
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 8
//    }
    
    //MARK: -UICollection
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = newsArray[(collectionView as! IndexCollectionView).indexPath!.row]
//        print(min(3, model.imageUrl!.count))
        return min(3, model.imageUrl!.count)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCell
        let model = newsArray[(collectionView as! IndexCollectionView).indexPath!.row]
        let imgUrl = model.imageUrl![indexPath.row]
        cell.imageView.kf_setImageWithURL(NSURL(string: imgUrl)!,placeholderImage: UIImage(named: "ps"))
        cell.contentView.backgroundColor = UIColor.brownColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let model = newsArray[(collectionView as! IndexCollectionView).indexPath!.row]
        let imageWidth = (UIScreen.mainScreen().bounds.size.width - leftMargin - rightMargin - space*2)/3
        if model.imageUrl?.count == 1
        {
            collectionView.frame.size = CGSizeMake(160, collectionView.frame.size.height)
            return CGSize(width: 160, height: collectionView.frame.size.height)
        }
        else
        {
            return CGSize(width: imageWidth, height:collectionView.frame.size.height)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
    
    //MARK: - Other
    func messages()
    {
        
    }
    
    func showProfile()
    {
        guard let containerViewController = self.containerViewController()
        else
        {
            return
        }
        containerViewController.showLeftPanel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segment(segment: EBSegment, didSelectAtIndex index: Int) {
        print("select \(index)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
