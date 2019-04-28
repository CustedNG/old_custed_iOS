//
//  TCAccountViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCAccountViewController: UIViewController,buttonDelegate{
    let dataSource = ["换绑校园网账号","切换账号","关于我们","设置"]
    let imageDataSource = ["changeDr.svg","changeAccount.svg","aboutUs.svg","setting.svg"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.myView.cellIdentifier)
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: self.myView.cellIdentifier)
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        let SVGimage = SVGKImage.init(named: imageDataSource[indexPath.row])
        SVGimage?.size = CGSize.init(width: 20, height: 20)
        cell?.imageView?.image = SVGimage?.uiImage
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    let myView = TCAccountView()
    let myModel = TCAccountModel()
    var isLogin:Bool?
    var didStore:Bool?
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLogin = UserDefaults.standard.value(forKey: "isLogin") as? Bool
        if isLogin==true{
            self.myModel.gettingInfo {
                self.myView.nameLabel?.text = self.myModel.info?.realname
                self.myView.majorLabel?.text = self.myModel.info?.major
                self.myView.CIDLable?.text = "[CID: \(self.myModel.info?.cid ?? 0)] \(self.myModel.info?.student_id ?? 0)"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.loadView()
        
    }
    override func loadView() {
        super.loadView()
        self.view = myView
        self.myView.delegate = self
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "我的账号"
//        let rightImage = SVGKImage.init(named: "list.svg")
//        rightImage?.size = CGSize.init(width: 30, height: 30)
//        let rightButton = UIBarButtonItem.init(image: rightImage?.uiImage, style: .plain, target: self, action: #selector(rightButtonClicked))
//        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
    }
    //退出登陆按钮
    func buttonClicked() {
        TCUserManager.shared.logOut()
        self.myView.nameLabel?.text = "未登陆"
        self.myView.majorLabel?.text = ""
        self.myView.CIDLable?.text = ""
    }
    func imageViewClick(tag: Int) {
        switch tag {
            //1 教务系统
        case 1:do {
            
            }
            //2 资料库
        case 2:do {
            UIApplication.shared.open(URL.init(string: "https://blog.tusi.site/doc.html")!, options: [ : ], completionHandler: nil)
            }
            //3 BB平台
        case 3:do {
            
            }
        default:
            TCToast.showWithMessage("0 value got")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    @objc func rightButtonClicked(){
        
    }
    


}
