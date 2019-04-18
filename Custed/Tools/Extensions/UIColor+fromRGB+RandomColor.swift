//
//  UIColor+fromRGB.swift
//  Custed
//
//  Created by faker on 2019/3/28.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    class func FromRGB(RGB:UInt,alpha:CGFloat=1.0) -> UIColor {
        return UIColor.init(
            red: CGFloat((RGB & 0xFF0000) >> 16)/225.0,
            green: CGFloat((RGB & 0x00FF00) >> 8)/255.0,
            blue: CGFloat((RGB & 0x0000FF))/255.0,
            alpha: alpha)
    }
    class func RandomColor()->UIColor{
        return UIColor.init(
            red: .random(in: 0.0...1.0),
            green: .random(in: 0.0...1.0),
            blue: .random(in: 0.0...1.0),
            alpha: 1.0)
    }
}
