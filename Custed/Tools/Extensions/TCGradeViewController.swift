//
//  TCGradeViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCGradeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "成绩"
        let right = SVGKImage.init(named: "list.svg")
        right?.size = CGSize.init(width: 20, height: 20)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: right?.uiImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightNavClicked))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func loadView() {
    }
    
    @objc func rightNavClicked(){
        print("rightNav")
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
