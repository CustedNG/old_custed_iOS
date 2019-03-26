//
//  UIViewController+slideViewController.swift
//  Custed
//
//  Created by faker on 2019/3/24.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
// 做侧滑框的时候 用这个函数得到侧滑框的控制器去控制侧滑框的弹出和回收
extension UIViewController{
    
    func slideViewController() -> TCSlideViewController?{
        var vc = self.parent
        while (vc != nil) {
            if (vc?.isKind(of: TCSlideViewController.self))!{
                print("yes")
                return (vc as! TCSlideViewController)
            }
            else if ((vc?.parent) != nil) || (vc?.parent?.isKind(of: UINavigationController.self))! || (vc?.parent?.isKind(of: TCTabBarController.self))!{
                print(vc?.description ?? "no description")
                vc = vc?.parent
            }
            else{
                return nil
            }
        }
        return nil
    }
}
