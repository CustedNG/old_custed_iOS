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
    let slideViewWidth : CGFloat = floor(ScreenWidth*2.0/3.0)  //侧滑框的大小
    let slideScale : CGFloat = 0.8 //侧滑框出现时 主视图缩放比例
    let slideDragbleWidth : CGFloat = floor(ScreenWidth/7.0) //可呼出侧滑框的范围
    let slideMinDragLength : CGFloat = floor(ScreenWidth/3.0) //拖动100长度可以弹出侧滑框
    
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
            //把侧滑框移过去
            self.slideView?.transform = CGAffineTransform.init(translationX: -slideViewWidth, y: 0)
        }
        get{
            return self._slideViewController
        }
    }
    /*------------------------ 主视图控制器 -----------------*/
    private var _mainTabBarController : UITabBarController?
    var mainTabBarController : UITabBarController?{
        set(mainVC){
            if mainVC == nil{
                print("mainvc is nill")
                return
            }
            self._mainTabBarController = mainVC
            self.addChild(mainVC!)
            mainView?.addSubview((mainVC?.view)!)
            mainView?.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
        get{
            return self._mainTabBarController
        }
    }
    /*------------------------ property config -----------------*/
    var canShow : Bool = true //是否可以弹出
    var isShowing : Bool = false //是否侧滑框已经弹出
    var startPoint : CGPoint? //滑的起始点
    var endPoint : CGPoint? //滑的结束点
    
    init(SlideViewController:UIViewController,MainTabBarController:UITabBarController) {
        super.init(nibName: nil, bundle: nil)
        self.initConfig()
        self.mainTabBarController = MainTabBarController
        self.slideViewController = SlideViewController
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.slideView?.isHidden = true
    }
    
    func initConfig(){
        let view_frame = self.view.bounds
        
        mainView = UIView.init(frame: view_frame)
//        slideView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: slideViewWidth, height: ScreenHeight))
        slideView = UIView.init(frame: view_frame)
        maskView = UIView.init(frame: view_frame)
        maskView?.isHidden = true
        maskView?.backgroundColor = UIColor.black
        maskView?.alpha = 0
        
        self.view.addSubview(mainView!)
        self.view.addSubview(slideView!)
        mainView?.addSubview(maskView!)
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureHandler(gestureRecognizer:)))
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureHandler))
        panGesture.delegate = self
        mainView?.addGestureRecognizer(panGesture)
        
        maskView?.addGestureRecognizer(tapGesture)
    }
    
    
    /*------------------------ UIGestureRecognizerDelegate协议方法 -----------------*/
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //判断只能在homepage 进行侧滑框
        if self.mainTabBarController?.selectedIndex != 0 {
            return false
        }
        //判断侧滑的起始位置是否可以唤起侧滑框
        let point : CGPoint = gestureRecognizer.location(in: self.view)
        if point.x <= slideDragbleWidth{
            return true
        }
        return false
        
    }
    /*------------------------ 手势处理 -----------------*/
    @objc func panGestureHandler(gestureRecognizer:UIGestureRecognizer){
        let point : CGPoint = gestureRecognizer.location(in: self.view)
        
        switch gestureRecognizer.state {
        case .began: do {
            print("begin")
            if isShowing{
                canShow = false
            }
            //记录起始点 ，为防止endPoint 为nil 先记录下
            startPoint = point
            endPoint = point
            self.slideView?.isHidden = false
            self.view.bringSubviewToFront(self.mainView!)
            self.maskView?.isHidden = false
            self.mainView?.bringSubviewToFront(self.maskView!)
            }
        case .changed:do {
            //如果不能展示 直接break
            if canShow == false{
                break
            }
            //根据拖动距离来进行按比例的移动
            //self.view.bringSubviewToFront(self.mainView!)
            let movedWidth:CGFloat = endPoint!.x - point.x
            let totalMovedWidth : CGFloat = startPoint!.x - point.x
            endPoint = point
            print(movedWidth)
            //var MainX:CGFloat = (mainView?.frame.origin.x)!
            if totalMovedWidth > 0 { //如果大于0说明往左滑
                break
            }
            if totalMovedWidth < -slideViewWidth{ //滑过头了
                break
            }
            //根据拖动大小缩放
            self.mainView?.transform = CGAffineTransform.translatedBy((self.mainView?.transform)!)(x: -movedWidth, y: 0)
            self.slideView?.transform = CGAffineTransform.translatedBy((self.slideView?.transform)!)(x: -movedWidth/2, y: 0)
            self.maskView?.alpha = 0.5*(-totalMovedWidth/slideViewWidth)
            print("total:",-totalMovedWidth)
            endPoint = point
            }
        case .ended: do{
            let movedWidth = startPoint!.x-endPoint!.x
            let MainX = self.mainView?.frame.origin.x
            let time : TimeInterval = TimeInterval(0.5*(1-(MainX!/slideViewWidth)))
            if movedWidth < -slideViewWidth{ //已经滑好了啊
                break
            }
            if movedWidth < -slideMinDragLength{
                self.showSlide(time)
            }
            else{
                self.hideSlide(time)
            }
            }
        case .possible: print("switch possible")
        case .cancelled: print("switch cancelled")
        case .failed: print("switch failed ")
        @unknown default:
            print("swift unknown default")
        }
    }
    @objc func tapGestureHandler(){
        self.hideSlide()
    }
    /*------------------------ 侧滑框的show与hide -----------------*/
    
    func showSlide(_ Duration:TimeInterval=0.5){
        self.slideView?.isHidden = false
        self.maskView?.isHidden = false
        self.mainView?.bringSubviewToFront(self.maskView!)
        self.view.bringSubviewToFront(self.mainView!)
        UIView.animate(withDuration: Duration, animations: {
            self.slideView?.transform = CGAffineTransform.init(translationX: -self.slideViewWidth/2, y: 0)
//            self.slideView?.transform = CGAffineTransform.scaledBy((self.slideView?.transform)!)(x: 1, y: 1)
            self.mainView?.transform = CGAffineTransform.init(translationX: self.slideViewWidth, y: 0)
//            self.mainView?.transform = CGAffineTransform.scaledBy((self.mainView?.transform)!)(x: self.slideScale, y: self.slideScale)
            self.maskView?.alpha = 0.5
            
        }) { (finished) in
            self.isShowing = true
        }
    }
    func hideSlide(_ Duration:TimeInterval=0.5){
        UIView.animate(withDuration: Duration, animations: {
            self.mainView?.transform = CGAffineTransform.init(translationX: 0, y: 0)
//            self.mainView?.transform = CGAffineTransform.scaledBy((self.mainView?.transform)!)(x: 1, y: 1)
            
            self.slideView?.transform = CGAffineTransform.init(translationX: -self.slideViewWidth, y: 0)
//            self.slideView?.transform = CGAffineTransform.scaledBy((self.slideView?.transform)!)(x: self.slideScale, y: self.slideScale)
            self.maskView?.alpha = 0
            
        }) { (finished) in
            self.isShowing = false
            self.maskView?.isHidden = true
            self.slideView?.isHidden = true
        }
    }
    
    
    
}
