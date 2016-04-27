//
//  String+URL.swift
//  EBMF
//
//  Created by randy on 16/4/27.
//  Copyright © 2016年 randy. All rights reserved.
//

import Foundation
extension String
{
    func isUrl()->Bool
    {
        return self.containsString("http://")
    }
}