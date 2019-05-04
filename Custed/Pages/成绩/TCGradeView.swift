//
//  TCGradeView.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
import SnapKit
protocol TCGradeViewProtocol:class{
    func clickedWith(tag:Int)
}
class TCGradeView: UIView,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var titleLabel:UILabel!
    var pageController:UIPageViewController
    let alertView:AlertTableView
    var gradeView:UITableView!
    var showCell=[IndexPath]()
    var leftArrowButton:UIButton!
    var rightArrowButton:UIButton!
    var Transition:CATransition!
    private var leftViewLabelArray=[UILabel]()
    private var leftViewController:LeftInPageViewController!
    private var rightViewController:RightViewControllerForPageController!
    private var ViewControllers : [UIViewController]!
    var GPARound:GPARoundView!
    private var level:GradeLevels!
    weak var clickDelegate:TCGradeViewProtocol?
    override init(frame: CGRect) {
        alertView = AlertTableView.init(startPosition:NavigationHeight+StatusBarheight, dataSouce: ["安全模式","强制刷新","bug反馈"])
        pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    func setUpUI(leftP:GradePersonalInfo,leftT:GradeTotal,leftR:gradeRanking,level:GradeLevels){
        self.level = level
        //渐变部分
        let gradientColors = [
            UIColor.FromRGB(RGB: 0x34C6FB).cgColor,
            UIColor.FromRGB(RGB: 0x4A9FF2).cgColor]
        var gradientBGColorFrame:CGRect
        if ScreenHeight/3 <= 220{
            gradientBGColorFrame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 220+NavigationHeight+StatusBarheight)
        }
        else{
            gradientBGColorFrame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight/3+NavigationHeight+StatusBarheight)
        }
        let gradientColor = CAGradientLayer()
        gradientColor.startPoint = CGPoint.init(x: 0, y: 0)
        gradientColor.endPoint = CGPoint.init(x: 1, y: 0)
        gradientColor.colors = gradientColors
        gradientColor.frame = gradientBGColorFrame
        
        //upper part View,and it contains all the widgets above the gradient color
        let upperPartView = UIView.init(frame: gradientBGColorFrame)
        upperPartView.layer.insertSublayer(gradientColor, at: 0)
        self.addSubview(upperPartView)
        
        //顶部title
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = "testing"
        titleLabel.backgroundColor = .clear
        upperPartView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(NavigationHeight+StatusBarheight)
            make.width.lessThanOrEqualToSuperview()
        }
        // two arrow buttons
        let svgSize = CGSize.init(width: 30*ScreenWidth/414, height: 30*ScreenWidth/414)
        let leftArrow = SVGKImage.init(named: "left.svg")
        leftArrow?.size = svgSize
        let arrowImage = leftArrow?.uiImage.imageWithColor(color: .white)
        leftArrowButton = UIButton.init(type: .custom)
        leftArrowButton.setBackgroundImage(arrowImage, for: .normal)
        leftArrowButton.addTarget(self, action: #selector(leftArrowClicked), for: .touchUpInside)
        upperPartView.addSubview(leftArrowButton)
        leftArrowButton.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp_left)
            make.centerY.equalTo(titleLabel)
        }
        
        rightArrowButton = UIButton.init(type: .custom)
        rightArrowButton.isEnabled = false //at beginning , we'll present last semester,so disable the right button
        rightArrowButton.setBackgroundImage(arrowImage, for: .normal)
        rightArrowButton.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
        rightArrowButton.addTarget(self, action: #selector(rightArrowClicked), for: .touchUpInside)
        upperPartView.addSubview(rightArrowButton)
        rightArrowButton.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_right)
            make.centerY.equalTo(titleLabel)
        }
        //alert view
        self.addSubview(alertView)
        alertView.isHidden = true
        
        
        // pageController and pages
        leftViewController = LeftInPageViewController.init(leftP: leftP, leftT: leftT,leftR: leftR)
        //left for Range right for GPA
        rightViewController = RightViewControllerForPageController.init(frame: gradientBGColorFrame, level: level)
        ViewControllers = [leftViewController,rightViewController]
        pageController.delegate = self
        pageController.dataSource = self
        upperPartView.addSubview(pageController.view)
        pageController.view.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.pageController.setViewControllers([rightViewController], direction: .forward, animated: false, completion: nil)
        
        
        /*----------Grade-----------*/
        gradeView = UITableView.init(frame: CGRect.zero, style: .plain)
        gradeView.delegate = self
        gradeView.dataSource = self
        gradeView.backgroundColor = .white
        gradeView.tintColor = UIColor.white
        gradeView.separatorStyle = .none
        gradeView.estimatedRowHeight = 0
        //gradeView.estimatedRowHeight = 60
        //gradeView.style
        gradeView.register(TCGradeBox.self, forCellReuseIdentifier: "GradeBox")
        self.addSubview(gradeView)
        gradeView.snp.makeConstraints { (make) in
            make.top.equalTo(upperPartView.snp_bottom)
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(ScreenHeight-TabBarHeight-upperPartView.frame.height)
        }
        Transition = CATransition.init()
        Transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        Transition.duration = 0.5
        Transition.type = .moveIn
        titleLabel.layer.add(Transition, forKey: "titleAN")
        titleLabel.text = level.description
        // push : push to right
    }
    func reloadData(levels:GradeLevels,animation:UITableView.RowAnimation){
        if animation == .left{
            Transition.type = .moveIn
        }
        else{
            Transition.type = .reveal
        }
        self.titleLabel.layer.add(Transition, forKey: "titleAN")
        self.titleLabel.text = levels.description
        self.level = levels
        rightViewController.reloadData(DataSource: self.level)
        gradeView.reloadSections(IndexSet.init(integer: 0), with: animation)
        //gradeView.reloadData()
    }
    @objc func test(sender:UITapGestureRecognizer){
        print(sender.view!.frame)
        
        
    }
    
    @objc func leftArrowClicked(){
        self.clickDelegate?.clickedWith(tag: 0)
    }
    @objc func rightArrowClicked(){
        self.clickDelegate?.clickedWith(tag: 1)
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return ViewControllers.firstIndex(of: rightViewController)!
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //trigger when swipe to left
        let currentIndex = ViewControllers.firstIndex(of: viewController)!
        if currentIndex == 0{
            return nil
        }
        return ViewControllers[currentIndex - 1]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //trigger when swipe to right
        let currentIndex = ViewControllers.firstIndex(of: viewController)!
        if currentIndex == ViewControllers.count-1{
            return nil
        }
        return ViewControllers[currentIndex + 1]
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    func animationWith(GPA:CGFloat){
        self.rightViewController.GPA = GPA
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TCGradeBox
        var frame = cell.frame
        if showCell.contains(indexPath){
            frame = CGRect.init(x: frame.minX, y: frame.minY, width: frame.width, height: 200)
            showCell.removeAll { (index) -> Bool in
                if index == indexPath{
                    return true
                }
                else{
                    return false
                }
            }
        }else{
            showCell.append(indexPath)
        }
        cell.expend = !cell.expend
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showCell.contains(indexPath) == true{
            return 160
        }
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return level.exams?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //disable cell reuse
        var cell:TCGradeBox? = tableView.dequeueReusableCell(withIdentifier: "GradeBox\(indexPath)") as? TCGradeBox
        if cell == nil{
            cell = TCGradeBox.init(style: .default, reuseIdentifier: "GradeBox\(indexPath)")
        }
        cell?.exam = level.exams![indexPath.row]
        if self.showCell.contains(indexPath) == true{
            cell?.expend = true
        }
        else{
            cell?.expend = false
        }
        cell!.selectionStyle = .none
        return cell!
    }
}
extension UIView{
    var MyViewController:UIViewController?{
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
