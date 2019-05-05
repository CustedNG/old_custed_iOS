//
//  TCGradeViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
import Foundation
/*
 Something haven't done:
 3.All the alert click event handling not implement(force to update ,security mode)
 */
class TCGradeViewController: UIViewController,AlertTableViewProtocol,TCGradeViewProtocol{
    func clickAlertCells(with: Int) {
        switch with {
        case 0:do{
            //security mode
            TCHUD.show()
            myView.alertView.Hide()
            }
        case 1:do{
            myView.alertView.Hide()
            TCHUD.show()
            myModel.getData(isremote: true) { (isSucessful) in
                if isSucessful == false{
                    TCHUD.dissmiss()
                    TCToast.showWithMessage("更新失败～请确保网络状况良好后重试")
                }
                else{
                    self.gotData = true
                    self.presentSemester = self.myModel.grade?.lastSemester ?? "1"
                    self.maxSemester = Int(self.presentSemester)
                    self.PersonalInfo = self.myModel.grade?.data.personal_info
                    self.total = self.myModel.grade?.data.total
                    self.levels = (self.myModel.grade?.data.levels)!
                    self.myView.setUpUI(leftP: self.PersonalInfo, leftT: self.total,leftR:self.myModel.grade!.rankings! ,level: self.levels[self.presentSemester]!)
                    TCHUD.dissmiss()
                }
            }
            }
        case 2:do{
            // bug
            }
        default:
            print("bug")
        }
    }
    func clickedWith(tag: Int) {
        switch tag {
        case 0:do{
            myView.rightArrowButton.isEnabled = true
            var presentInt=Int(self.presentSemester)!
            presentInt -= 1
            if presentInt == 1{
                myView.leftArrowButton.isEnabled = false
            }
            self.presentSemester = String(presentInt)
            myView.reloadData(levels: self.levels[self.presentSemester]!, animation: .right)
            }
        case 1:do{
            myView.leftArrowButton.isEnabled = true
            var presentInt=Int(self.presentSemester)!
            presentInt += 1
            if presentInt == maxSemester{
                myView.rightArrowButton.isEnabled = false
            }
            self.presentSemester = String(presentInt)
            myView.reloadData(levels: self.levels[self.presentSemester]!, animation: .left)
            }
        default:
            print("出鬼啦")
        }
    }
    var presentSemester:String = "1"
    var maxSemester:Int!
    private var cancelBarItem:UIBarButtonItem!
    private var rightBarItem:UIBarButtonItem!
    private var needGetData:Bool = false
    private var gotData:Bool = false
    private var isFirstTime:Bool = true
    var myView = TCGradeView()
    var myModel = TCGradeModel()
    //for left view in pageVC,and it's needn't to refresh
    private var PersonalInfo:GradePersonalInfo!
    private var total:GradeTotal!
    
    //for right View in PageVC and tableView
    private var levels:[String:GradeLevels]!
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
        print(gotData,isFirstTime)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(needGetData)
        if TCUserManager.shared.hadLoginIn(){
            needGetData = true
        }
        if needGetData == true{
            myModel.getData(isremote: false) { (isSucessful) in
                if isSucessful == true{
                    self.gotData = true
                    self.presentSemester = self.myModel.grade?.lastSemester ?? "1"
                    self.maxSemester = Int(self.presentSemester)
                    self.PersonalInfo = self.myModel.grade?.data.personal_info
                    self.total = self.myModel.grade?.data.total
                    self.levels = (self.myModel.grade?.data.levels)!
                    self.myView.setUpUI(leftP: self.PersonalInfo, leftT: self.total,leftR:self.myModel.grade!.rankings! ,level: self.levels[self.presentSemester]!)
                }
                else{
                    TCToast.showWithMessage("请求数据失败")
                }
            }
        }
        
    }
    func packageDataToView(){
        self.presentSemester = self.myModel.grade?.lastSemester ?? "1"
        self.maxSemester = Int(self.presentSemester)
        self.PersonalInfo = self.myModel.grade?.data.personal_info
        self.total = self.myModel.grade?.data.total
        self.levels = (self.myModel.grade?.data.levels)!
        self.myView.setUpUI(leftP: self.PersonalInfo, leftT: self.total,leftR:self.myModel.grade!.rankings! ,level: self.levels[self.presentSemester]!)
        self.gotData = true
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "成绩"
        let close = SVGKImage.init(named: "close.svg")
        close?.size = CGSize.init(width: 25, height: 25)
        cancelBarItem = UIBarButtonItem.init(image: close?.uiImage, style: .plain, target: self, action: #selector(rightNavClose))
        //self.navigationItem.prompt = "test"
        let right = SVGKImage.init(named: "list.svg")
        right?.size = CGSize.init(width: 25, height: 25)
        rightBarItem = UIBarButtonItem.init(image: right?.uiImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightNavClicked))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func loadView() {
        self.view = myView
        //self.addChild(myView.pageController)
        myView.clickDelegate = self
        myView.alertView.alertDelegate = self
    }
    
    @objc func rightNavClicked(){
        self.navigationItem.setRightBarButton(cancelBarItem, animated: true)
        myView.alertView.Show()
    }
    @objc func rightNavClose(){
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
        myView.alertView.Hide()
    }
    
    
}
