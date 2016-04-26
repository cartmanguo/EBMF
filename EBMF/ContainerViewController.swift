//
//  ViewController.swift
//  EBMF
//
//  Created by randy on 16/4/22.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    var distance:CGFloat = 0
    var FullDistance: CGFloat = 0.78
    var Proportion: CGFloat = 0.77

    var homeNavVC:UINavigationController!
    var menuVC:LeftMenuViewController!
    
    var panGesture: UIScreenEdgePanGestureRecognizer!
    var tapGesture:UITapGestureRecognizer!
    var mainView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = UIView(frame: view.bounds)
        let bgImageView = UIImageView(frame: view.bounds)
        bgImageView.contentMode = .ScaleAspectFill
        mainView.clipsToBounds = true
        bgImageView.image = UIImage(named: "re.jpg")
        view.addSubview(bgImageView)
        menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftMenu")  as! LeftMenuViewController
        //menuVC.view.center.x = -40
        menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3)
        menuVC.view.center = view.center
        view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.didMoveToParentViewController(self)
        view.addSubview(mainView)

        let homeVC = HomeViewController()
        homeNavVC = UINavigationController(rootViewController: homeVC)
        //view.sendSubviewToBack(bgImageView)
        mainView.addSubview(homeNavVC.view)
        mainView.addSubview(homeVC.view)
        mainView.addSubview((self.tabBarController?.tabBar)!)
        self.addChildViewController(homeNavVC)
        homeNavVC.didMoveToParentViewController(self)
        panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ContainerViewController.pan))
        panGesture.edges = .Left
        mainView.addGestureRecognizer(panGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ContainerViewController.showCenterPanel))
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func pan(sender: AnyObject)
    {
        let translateDistance = panGesture.translationInView(view).x
        let fullDistance = distance + translateDistance
//        let trueProportion = fullDistance / (screenWidth*FullDistance)
//        print(fullDistance)
        if panGesture.state == .Ended
        {
            if fullDistance > screenWidth / 2
            {
                showLeftPanel()
            }
            else
            {
                showCenterPanel()
            }
        }
        let mainViewScale = (Proportion - 1)/(screenWidth * 0.95) * fullDistance + 1
//        print(mainViewScale)
        let moveXDistance = FullDistance * fullDistance
        panGesture.view?.transform = CGAffineTransformMakeScale(mainViewScale, mainViewScale)
        panGesture.view?.frame.origin = CGPointMake(moveXDistance,(panGesture.view?.frame.origin.y)!)
        let leftMenuScale = (1 - 1.3)/(screenWidth * 0.95) * fullDistance + 1.3
//        print(leftMenuScale)
        menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftMenuScale, leftMenuScale)
        let alpha = fullDistance/screenWidth * 0.95
        menuVC.view.alpha = alpha
    }
    
    func showLeftPanel()
    {
        //what has to be executed in main thread???
        dispatch_async(dispatch_get_main_queue(), {() in
            self.distance = self.view.center.x * (self.FullDistance*2 + self.Proportion - 1)
//            print(distance)
            self.doTheAnimate(self.Proportion)
        })
        mainView.removeGestureRecognizer(panGesture)
        mainView.addGestureRecognizer(tapGesture)
    }
    
    func showCenterPanel()
    {
        dispatch_async(dispatch_get_main_queue(), {() in
            self.distance = 0
            //            print(distance)
            self.doTheAnimate(1)
        })
        mainView.removeGestureRecognizer(tapGesture)
        mainView.addGestureRecognizer(panGesture)
    }
    
    func doTheAnimate(proportion: CGFloat) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.mainView.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
            self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
            if proportion == 1
            {
                //self.menuVC.view.center.x = self.view.center.x-80
                self.menuVC.view.alpha = 0
                self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3)
            }
            else
            {
                //self.menuVC.view.center.x = self.view.center.x
                self.menuVC.view.alpha = 1
                self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)

            }
            
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

