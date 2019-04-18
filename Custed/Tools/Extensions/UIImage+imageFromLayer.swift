//
//  UIImage+imageFromLayer.swift
//  Custed
//
//  Created by faker on 2019/4/16.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    class func imageFrom(bounds:CGRect) ->UIImage{
        let gradientColors = [
            UIColor.FromRGB(RGB: 0x34C6FB).cgColor,
            UIColor.FromRGB(RGB: 0x4A9FF2).cgColor
        ]
        let gradientNavBar = CAGradientLayer()
        gradientNavBar.frame = bounds
        gradientNavBar.startPoint = CGPoint.init(x: 0, y: 0)
        gradientNavBar.endPoint = CGPoint.init(x: 1, y: 0)
        gradientNavBar.colors = gradientColors
        UIGraphicsBeginImageContext(gradientNavBar.frame.size)
        gradientNavBar.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

