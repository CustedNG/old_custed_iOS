//
//  Const.swift
//  Custed
//
//  Created by faker on 2019/3/4.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
//布局第三方框架
import SnapKit
import Alamofire

/*--------------------------屏幕信息--------------------------*/
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

/*--------------------------设备信息--------------------------*/
let isIphone = UIDevice.current.userInterfaceIdiom.rawValue == 0
let isIphoneXOrAbove = (ScreenHeight == 812 || ScreenHeight == 896) ? true : false
let isUnderIphoneX = (ScreenHeight == 812 || ScreenHeight == 896) ? false : true
let isIpad = UIDevice.current.userInterfaceIdiom.rawValue == 1
/*--------------------------屏幕适配设置--------------------------*/
//顶部的statusbar高度
let StatusBarheight :CGFloat = isIphoneXOrAbove ? 44 : 20
//对于iphonex以上的 刘海长度
let AlertStatusBarHeight : CGFloat = isIphoneXOrAbove ? 44 : 0
//底端的tabbar高度
let TabBarHeight :CGFloat = isIphoneXOrAbove ? 49 + 34 : 49
//左右两端的空隙
let compactWidth : CGFloat = isIpad ? 20 : 16
//上方的空隙
let compactHeigh : CGFloat = isIpad ? 30 : 20
//从iphone 到 ipad 的字体放大倍数
let Iphone2IpadScale : CGFloat = 1.8
//从iphone 到 ipad 的图片放大倍数
let Iphone2IpadIamgeScale : CGFloat = 1.5
/*--------------------------用户的网络状况（有网或者没得网）--------------------------*/
