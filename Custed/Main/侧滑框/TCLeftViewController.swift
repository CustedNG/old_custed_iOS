//
//  TCLeftViewController.swift
//  Custed
//
//  Created by faker on 2019/3/24.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCLeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    private let _dataSource : Array = ["1","2"]
    let identifier:String = "cell"
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.view.frame = CGRect.init(x: 0, y: 0, width: , height: ScreenHeight)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth/3.0, height: ScreenHeight)) //be hidden
        leftView.backgroundColor = UIColor.red
        let rightView = UIView.init(frame: CGRect.init(x: ScreenWidth/3.0, y: 0, width: ScreenWidth*2.0/3.0, height: ScreenHeight))
        self.view.addSubview(leftView)
        self.view.addSubview(rightView)
        
        
        let img = UIImageView.init(image: UIImage.init(named: "13.jpg"))
        img.clipsToBounds = true
        rightView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(ScreenHeight/3)
        }
        
        //table View
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: ScreenHeight/3, width: ScreenWidth*2/3, height: CGFloat(44*_dataSource.count)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 44
        rightView.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    

}
