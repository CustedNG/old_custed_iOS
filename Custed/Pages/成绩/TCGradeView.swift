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
class TCGradeView: UIView,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ScreenWidth - 60, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        print(cell?.frame)
    }
    
    var titleLabel:UILabel!
    var pageController:UIPageViewController
    let alertView:AlertTableView
    private var leftViewLabelArray=[UILabel]()
    private var leftViewController:UIViewController!
    private var rightViewController:RightViewControllerForPageController!
    private var ViewControllers : [UIViewController]!
    var GPARound:GPARoundView!
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
    func setUpUI(){
        
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
        
        //upper part View , and it contains all the widgets above the gradient color
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
        let leftArrowButton = UIButton.init(type: .custom)
        leftArrowButton.setBackgroundImage(arrowImage, for: .normal)
        leftArrowButton.addTarget(self, action: #selector(leftArrowClicked), for: .touchUpInside)
        upperPartView.addSubview(leftArrowButton)
        leftArrowButton.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp_left)
            make.centerY.equalTo(titleLabel)
        }
        
        let rightArrowButton = UIButton.init(type: .custom)
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
        leftViewController = LeftInPageViewController.init()
        //left for Range right for GPA
        rightViewController = RightViewControllerForPageController.init(frame: gradientBGColorFrame)
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
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        
    
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
