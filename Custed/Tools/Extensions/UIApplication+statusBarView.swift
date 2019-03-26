//
//  UIApplication+statusBarView.swift
//  Custed
//
//  Created by faker on 2019/3/25.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
//自定义statusbar
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
