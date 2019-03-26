//
//  TCTabBarController.swift
//  Custed
//
//  Created by faker on 2019/3/4.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCTabBarController: UITabBarController, UITabBarControllerDelegate {
    private var allFunctionAlertVC : TCAllFunctionViewController?
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
        let test :WYYTestViewController = WYYTestViewController()
        let allfunctionVC:TCAllFunctionWebViewController = TCAllFunctionWebViewController()
        let homepageVC : TCHomePageViewController = TCHomePageViewController()
        let nav :UINavigationController = UINavigationController.init(rootViewController: homepageVC)
        self.viewControllers = [nav,test,allfunctionVC]
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
