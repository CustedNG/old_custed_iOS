//
//  TCScheduleViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCScheduleViewController: UIViewController,titleVIewClick,ScheduleViewProtocol{
    func AlertCancel() {
        alertView.closeDetailAlert()
    }
    
    func arrowButtonForTitleViewClicked(tag: Int) {
        switch tag {
        case 1:
            do{
                self.titleView.weeksLabel.layer.add(self.fadeAnimation, forKey: "fade")
                if self.presentWeek > 1{
                    self.presentWeek -= 1
                    self.reloadCollectionViewData()
                }
            }
        case 2:
            do{
                self.titleView.weeksLabel.layer.add(self.fadeAnimation, forKey: "fade")
                self.presentWeek += 1
                if self.presentWeek == 25{
                    self.presentWeek = 1
                }
                self.reloadCollectionViewData()
            }
        case 3:
            do{
                print("3")
            }
        default:
            print("nononono")
        }
    }
    
    func clickCells(collectionView:UICollectionView,cell:cellsForScheduleView,index: IndexPath) {
        if cell.info == nil{
            return
        }
        //print(cell.info?.lesson_name)
        print(cell.backgroundColor)
        alertView.showDetail(collectionView:collectionView, frame: cell.frame, lesson: cell.info, color: cell.backgroundColor)
        //print(cell.frame)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:cellsForScheduleView = collectionView.dequeueReusableCell(withReuseIdentifier: myView.cellsIdentifier, for: indexPath) as! cellsForScheduleView
        //week:[day:[[start_section:lesson]]]
        cell.backgroundColor = UIColor.white
        let currentWeek = self.presentWeek
        if myModel.data.ScheduleForWeeks[currentWeek]![indexPath.row+1] == nil{
            cell.info = nil
            return cell
        }
        
        let lesson:lesson? = myModel.data.ScheduleForWeeks[currentWeek]![indexPath.row+1]![indexPath.section*2+1]
        if  lesson == nil{
            cell.info = nil
            return cell
        }
        else{
            //print(indexPath,lesson!.color)
            if lesson?.lesson_type != 1{
                cell.backgroundColor = myModel.othersColor
            }
            else{
                let colorIndex = myModel.data.lessonColorIndex[lesson!.lesson_name]
                cell.backgroundColor = myModel.colorArray[colorIndex!]
                //print(myModel.data.lessonColor[lesson!.lesson_name])
            }
            cell.nameLabel.text = lesson!.lesson_name
            print(lesson!.lesson_name,myModel.data.lessonColorIndex[lesson!.lesson_name])
            cell.positionLabel.text = "@"+lesson!.location
            cell.info = lesson
        }
        return cell
    }
    

    let myView = TCScheduleView()
    let myModel = TCScheduleModel()
    let titleView = ScheduleTitleView.init()
    lazy var alertView = ClassDetailsView()
    var presentWeek : Int = 0
    var fadeAnimation:CATransition!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myModel.getScheduleData {
            self.myView.widgetsPrepare()
            self.presentWeek = self.gettingCurrentWeek()
            self.myModel.weeks[self.presentWeek-1] += " 当前周"
            self.assignToViews()
            self.fadeAnimation = CATransition()
            self.fadeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            self.fadeAnimation.type = .fade
            self.fadeAnimation.duration = 0.5
            self.titleView.weeksLabel.layer.add(self.fadeAnimation, forKey: "fade")
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
    func gettingCurrentWeek()->Int{
        let now = Date.init(timeIntervalSinceNow: 0)
        if myModel.data.semesterStartTime == nil{
            return 1
        }
        let interval = Calendar.current.dateComponents([.weekdayOrdinal], from: myModel.data.semesterStartTime!, to: now)
        return interval.weekdayOrdinal! + 1
    }
    override func loadView() {
        myView.delegate = self
        self.titleView.delegate = self
        self.view = myView
    }
    
    @objc func rightNavClicked(){
        TCHUD.show()
        myModel.forceUpdate {
            self.presentWeek = self.gettingCurrentWeek()
            self.assignToViews()
            self.reloadCollectionViewData()
            TCHUD.dissmiss()
        }
    }
    func assignToViews(){
        self.titleView.weeksLabel.text = self.myModel.weeks[self.presentWeek-1]
        self.titleView.semesterLabel.text = self.myModel.data.semester
        self.myView.dayInWeekLabels[0].text = self.myModel.data.schedule[self.presentWeek]![0]
        print(self.myModel.data.schedule[self.presentWeek]![0])
        for i in 1..<8{
            self.myView.dayInMonthLabels[i].text = self.myModel.data.schedule[self.presentWeek]![i]
        }
    }
    func reloadCollectionViewData(){
        myView.classSchedule.reloadData()
        self.titleView.weeksLabel.text = self.myModel.weeks[self.presentWeek-1]
        self.myView.dayInWeekLabels[0].text = self.myModel.data.schedule[self.presentWeek]![0]
        print(self.myModel.data.schedule[self.presentWeek]![0])
        for i in 1..<8{
            self.myView.dayInMonthLabels[i].text = self.myModel.data.schedule[self.presentWeek]![i]
        }
    }
    
}
