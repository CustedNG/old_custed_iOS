//
//  UIViewController+slideViewController.swift
//  Custed
//
//  Created by faker on 2019/3/24.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
// 做侧滑框的时候 用这个函数得到侧滑框的控制器去控制侧滑框的弹出
extension UIViewController{
    
    func slideViewController() -> TCSlideViewController?{
        var vc = self.parent
        if (vc?.isKind(of: TCSlideViewController.self))!{
            print("yes")
        }
        else{
            print(vc?.description ?? "no description")
        }
        return nil
    }
}
