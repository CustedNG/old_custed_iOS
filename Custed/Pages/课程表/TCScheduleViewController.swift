//
//  TCScheduleViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCScheduleViewController: UIViewController,titleVIewClick{
    func arrowButtonForTitleViewClicked(tag: Int) {
        
    }
    

    let myView = TCScheduleView()
    let myModel = TCScheduleModel()
    let titleView = ScheduleTitleView.init()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myModel.getScheduleData {
            self.titleView.weeksLabel.text = "第一周"
            self.titleView.semesterLabel.text = self.myModel.data.semester
            let currentWeek = self.myModel.data.currentWeeks
            self.myView.dayInWeekLabels[0].text = self.myModel.data.schedule[currentWeek]![0]
            print(self.myModel.data.schedule[currentWeek]![0])
            for i in 1..<8{
                self.myView.dayInMonthLabels[i].text = self.myModel.data.schedule[currentWeek]![i]
            }
        }
        
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "课程表"
        //self.navigationItem.prompt = "test"
        let right = SVGKImage.init(named: "list.svg")
        right?.size = CGSize.init(width: 25, height: 25)
        self.navigationItem.titleView = titleView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: right?.uiImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightNavClicked))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func loadView() {
        self.view = myView
    }
    
    @objc func rightNavClicked(){
        print("rightNav")
    }

}
