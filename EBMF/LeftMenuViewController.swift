//
//  LeftMenuViewController.swift
//  EBMF
//
//  Created by randy on 16/4/22.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var genderIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var earnPointsButton: UIButton!
    @IBOutlet weak var menuView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        menuView.tableFooterView = UIView()
        menuView.separatorStyle = .None
        //self.edgesForExtendedLayout = .None
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = menuView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = "PCM"
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.backgroundColor = UIColor.clearColor()
        cell?.contentView.backgroundColor = UIColor.clearColor()
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
