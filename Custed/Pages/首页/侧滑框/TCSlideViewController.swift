//
//  TCSlideViewController.swift
//  Custed
//
//  Created by faker on 2019/3/24.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Foundation
class TCSlideViewController: UIViewController,UIGestureRecognizerDelegate {
    static let animationDuration : Float = 0.3 //动画持续时间
    
    /*------------------------ slide config -----------------*/
    static let slideViewWidth : Float = 240.0 //侧滑框的大小
    static let slideScale : Float = 0.8 //侧滑框出现时 主视图缩放比例
    static let slideDragbleWidth : Float = 80.0 //可呼出侧滑框的范围
    static let slideMinDragLength : Float = 100.0 //拖动100长度可以弹出侧滑框
    
    /*------------------------ widgets config -----------------*/
    private var slideView : UIView?
    private var mainView : UIView?
    private var maskView : UIView?
    
    /*------------------------ 侧滑控制器 -----------------*/
    private var _slideViewController : UIViewController?
    public var slideViewController : UIViewController?{
        set(slideVC){
            if slideVC == nil {
                print("can not be nil")
                return
            }
            canShow = true
            self._slideViewController = slideVC
            //因为要缩放视图，所以设置view的属性是上下左右都缩放
            self._slideViewController?.view.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
            self.addChild(slideVC!)
            self.slideView?.addSubview((slideVC?.view)!)
            
        }
        get{
            return self._slideViewController
        }
    }
    /*------------------------ 主视图控制器 -----------------*/
    private var _mainViewController : UIViewController?
    var mainViewController : UIViewController?{
        set(mainVC){
            if mainVC == nil{
                print("mainvc is nill")
                return
            }
            self._mainViewController = mainVC
            self.addChild(mainVC!)
            mainView?.addSubview((mainVC?.view)!)
            
        }
        get{
            return self._mainViewController
        }
    }
    /*------------------------ property config -----------------*/
    var canShow : Bool? //是否可以弹出
    var isShowing : Bool? //是否侧滑框已经弹出
    
    init(SlideViewController:UIViewController,MainViewController:UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.initConfig()
        self.mainViewController = MainViewController
        self.slideViewController = SlideViewController
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func initConfig(){
        let view_frame = self.view.bounds
        
        mainView = UIView.init(frame: view_frame)
        slideView = UIView.init(frame: view_frame)
        maskView = UIView.init(frame: view_frame)
        maskView?.isHidden = true
        
        self.view.addSubview(mainView!)
        self.view.addSubview(slideView!)
        mainView?.addSubview(maskView!)
        
        let panGesture = UIGestureRecognizer.init(target: self, action: #selector(panGestureHandler))
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureHandler))
        panGesture.delegate = self
        mainView?.addGestureRecognizer(panGesture)
        
        maskView?.addGestureRecognizer(tapGesture)
    }
    @objc func panGestureHandler(){
        
    }
    @objc func tapGestureHandler(){
        
    }
}
