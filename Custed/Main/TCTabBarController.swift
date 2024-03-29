//
//  TCTabBarController.swift
//  Custed
//
//  Created by faker on 2019/3/4.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCTabBarController: UITabBarController, UITabBarControllerDelegate {
    private var allFunctionAlertVC : TCAllFunctionContentViewController?
    private lazy var fcView : TCAllFunctionView = TCAllFunctionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        testSetting()
    }
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("NO")
    }
    func testSetting() -> Void {
        let bgImage:UIImage = UIImage.imageFrom(bounds: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: TabBarHeight+NavigationHeight))
        
        let test :WYYTestViewController = WYYTestViewController()
        let homepageVC : TCHomePageViewController = TCHomePageViewController()
        let homePageNav :UINavigationController = UINavigationController.init(rootViewController: homepageVC)
        homePageNav.navigationBar.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: TabBarHeight+NavigationHeight)
        let GradeVC : TCGradeViewController = TCGradeViewController()
        let GradeNav : UINavigationController = UINavigationController.init(rootViewController: GradeVC)
//        GradeNav.navigationBar.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: TabBarHeight+NavigationHeight)
        GradeNav.navigationBar.tintColor = UIColor.white
        GradeNav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        GradeNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        GradeNav.navigationBar.shadowImage = UIImage()
        GradeNav.navigationBar.backgroundColor = .clear
        GradeNav.navigationBar.isTranslucent = true
        //GradeNav.navigationBar.barTintColor = UIColor.white
        //GradeNav.navigationBar.setBackgroundImage(bgImage, for: .default)
        let allfunctionVC:TCAllFunctionContentViewController = TCAllFunctionContentViewController()
        let scheduleVC : TCScheduleViewController = TCScheduleViewController()
        let scheduleNav : UINavigationController = UINavigationController.init(rootViewController: scheduleVC)
        scheduleNav.navigationBar.tintColor = UIColor.white
        scheduleNav.navigationBar.setBackgroundImage(bgImage, for: .default)
        let accountVC : TCAccountViewController = TCAccountViewController()
        let accountNav : UINavigationController = UINavigationController.init(rootViewController: accountVC)
        accountNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        accountNav.navigationBar.shadowImage = UIImage()
        accountNav.navigationBar.backgroundColor = .clear
        accountNav.navigationBar.isTranslucent = true
//        accountNav.navigationBar.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: TabBarHeight+NavigationHeight)
        self.viewControllers = [homePageNav,GradeNav,allfunctionVC,scheduleNav,accountNav]
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if(viewController.tabBarItem.tag == 3){
            let windows :UIWindow = ((UIApplication.shared.delegate?.window)!)!
            windows.addSubview(self.fcView)
            self.fcView.snp.makeConstraints({ (make) in
                make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            })
            UIView.animate(withDuration: 1.5, animations: {
                self.fcView.mask?.isHidden = false
                self.fcView.mask?.alpha = 0
            }) { (true) in
                self.fcView.mask?.isHidden = true
                self.fcView.mask?.alpha = 1
            }
            
            return false
        }
        return true
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    

}
