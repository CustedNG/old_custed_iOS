//
//  UIFont+fontSizeToFit.swift
//  Custed
//
//  Created by faker on 2019/3/30.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
extension UIFont{
    class func fontFitHeight(size:CGFloat) -> UIFont {
        let fontSize = floor(size/896*ScreenHeight)
        return UIFont.systemFont(ofSize: fontSize)
    }
    class func fontFitWidth(size:CGFloat) -> UIFont{
        let fontSize = floor(size/414*ScreenWidth)
        return UIFont.systemFont(ofSize: fontSize)
    }
}
