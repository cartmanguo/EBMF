//
//  HomeViewController.swift
//  EBMF
//
//  Created by randy on 16/4/22.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,EBSegmentDelegate {
    var newsListView:UITableView!
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
        newsListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let segment = EBSegment(titles: ["PS","XBOX","在玩"])
        segment.delegate = self
        segment.frame = CGRectMake(0, 0, 185, 25)
        navigationItem.titleView = segment
        NewsManager.fetchNewsFromServer(.PlayStation, completionHandler: {(news) in
        })
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "SJB"
        return cell!
    }
    
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
