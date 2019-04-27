//
//  TCScheduleViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCScheduleViewController: UIViewController,titleVIewClick,ScheduleViewProtocol,AlertTableViewProtocol{
    //Tools alert
    func clickAlertCells(with: Int) {
        print(with)
        switch with {
        case 0:
            do{
                
            }
        case 1:
            do{
                
            }
        case 2:
            do{
                self.rightNavClose()
                TCHUD.show()
                myModel.forceUpdate {isSuccessful in
                    if isSuccessful == true{
                        self.reloadCollectionViewData()
                    }
                    TCHUD.dissmiss()
                }
            }
        case 3:
            do{
                
            }
        default: break
            
        }
    }
    //detail alert
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
                UsePickerView.showCustedDataPickerView()
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
        //print(cell.backgroundColor)
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
        if myModel.data.ScheduleForWeeks[currentWeek]?[indexPath.row+1] == nil{
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
            //print(lesson!.lesson_name,myModel.data.lessonColorIndex[lesson!.lesson_name])
            cell.positionLabel.text = "@"+lesson!.location
            cell.info = lesson
        }
        return cell
    }
    
    /*-------------property------------------------------------*/
    let myView = TCScheduleView()
    let myModel = TCScheduleModel()
    let titleView = ScheduleTitleView.init()
    //lazy var toolAlertBox = AlertTableView.init(dataSouce: ["我想蹭课","添加课程","强制刷新课表","bug提交"])
    lazy var alertView = ClassDetailsView()
    var presentWeek : Int = 0
    var fadeAnimation:CATransition!
    var cancelBarItem:UIBarButtonItem!
    var rightBarItem:UIBarButtonItem!
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
        let close = SVGKImage.init(named: "close.svg")
        close?.size = CGSize.init(width: 25, height: 25)
        cancelBarItem = UIBarButtonItem.init(image: close?.uiImage, style: .plain, target: self, action: #selector(rightNavClose))
        //self.navigationItem.prompt = "test"
        let right = SVGKImage.init(named: "list.svg")
        right?.size = CGSize.init(width: 25, height: 25)
        rightBarItem = UIBarButtonItem.init(image: right?.uiImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightNavClicked))
        self.navigationItem.titleView = titleView
        self.navigationItem.rightBarButtonItem = rightBarItem
        
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
        myView.toolAlertBox.alertDelegate = self
        self.view = myView
    }
    
    @objc func rightNavClicked(){
        myView.toolAlertBox.Show()
        self.navigationItem.setRightBarButton(cancelBarItem, animated:true)
        
    }
    @objc func rightNavClose(){
        myView.toolAlertBox.Hide()
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
    }
    
    /// Description: first time load data
    func assignToViews(){
        self.titleView.weeksLabel.text = self.myModel.weeks[self.presentWeek-1]
        self.titleView.semesterLabel.text = self.myModel.data.semester
<<<<<<< HEAD
        self.myView.dayInWeekLabels[0].text = self.myModel.data.schedule[self.presentWeek]?[0]
        print(self.myModel.data.schedule[self.presentWeek]?[0])
=======
        print(self.presentWeek)
        print(self.myModel.data.schedule)
        self.myView.dayInWeekLabels[0].text = self.myModel.data.schedule[self.presentWeek]![0]
        
        print(self.myModel.data.schedule[self.presentWeek]![0])
>>>>>>> eef1b5bb3c4bbcdf8bdd473d3399338f1877d7c3
        for i in 1..<8{
            self.myView.dayInMonthLabels[i].text = self.myModel.data.schedule[self.presentWeek]?[i]
        }
    }
    /// Description: call this function when presentWeek Changed or force to fresh class schedule
    func reloadCollectionViewData(){
        myView.classSchedule.reloadData()
        self.titleView.weeksLabel.text = self.myModel.weeks[self.presentWeek-1]
        self.myView.dayInWeekLabels[0].text = self.myModel.data.schedule[self.presentWeek]?[0]
        print(self.myModel.data.schedule[self.presentWeek]?[0])
        for i in 1..<8{
            self.myView.dayInMonthLabels[i].text = self.myModel.data.schedule[self.presentWeek]?[i]
        }
    }
    //--------------------------PICKER-----------------------------//
    lazy var UsePickerView = CustedDataPickerView()
    
}
