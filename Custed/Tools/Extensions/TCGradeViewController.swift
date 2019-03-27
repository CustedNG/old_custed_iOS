//
//  TCGradeViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCGradeViewController: UIViewController {

    let myView = TCGradeView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view = myView
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
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
