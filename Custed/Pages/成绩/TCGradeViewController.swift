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
class TCGradeViewController: UIViewController,AlertTableViewProtocol,TCGradeViewProtocol{
    func clickAlertCells(with: Int) {
        print(with)
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
    var myView = TCGradeView()
    var myModel = TCGradeModel()
    //for left view in pageVC,and it's needn't to refresh
    private var PersonalInfo:GradePersonalInfo!
    private var total:GradeTotal!
    
    //for right View in PageVC and tableView
    private var levels:[String:GradeLevels]!
    override func viewDidLoad() {
        super.viewDidLoad()
        myModel.getData {
            self.presentSemester = self.myModel.grade?.lastSemester ?? "1"
            self.maxSemester = Int(self.presentSemester)
            self.PersonalInfo = self.myModel.grade?.data.personal_info
            self.total = self.myModel.grade?.data.total
            self.levels = (self.myModel.grade?.data.levels)!
            self.myView.setUpUI(leftP: self.PersonalInfo, leftT: self.total,leftR:self.myModel.grade!.rankings! ,level: self.levels[self.presentSemester]!)
            //self.myView.assign(leftP: self.PersonalInfo, leftT: self.total, levels: self.levels[self.presentSemester]!)
        }
        
        
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
