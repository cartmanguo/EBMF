//
//  UIViewController+Container.swift
//  EBMF
//
//  Created by randy on 16/4/26.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
extension UIViewController
{
    func containerViewController()->ContainerViewController?
    {
        if (self.navigationController != nil)
        {
            let rootNav = self.navigationController
            return rootNav?.parentViewController as? ContainerViewController
        }
        return nil
    }
}
