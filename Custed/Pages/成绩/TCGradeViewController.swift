//
//  TCGradeViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCGradeViewController: UIViewController,AlertTableViewProtocol,TCGradeViewProtocol{
    func clickAlertCells(with: Int) {
        print(with)
    }
    func clickedWith(tag: Int) {
        switch tag {
        case 0:do{
            print("tag:0")
            }
        case 1:do{
            print("tag:1")
            }
        default:
            print("出鬼啦")
        }
    }
    private var cancelBarItem:UIBarButtonItem!
    private var rightBarItem:UIBarButtonItem!
    var myView = TCGradeView()
    var myModel = TCGradeModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.setUpUI()
        myView.animationWith(GPA: 4.0)
        //myView.pageController.didMove(toParent: self)
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
