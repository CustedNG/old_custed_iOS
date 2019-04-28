//
//  RightViewControllerForPageController.swift
//  Custed
//
//  Created by faker on 2019/4/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class RightViewControllerForPageController: UIViewController {
    private var GPARound:GPARoundView!
    private var frame:CGRect
    private var _GPA:CGFloat = 0.0
    var semeterLabel:UILabel!
    var classLabel:UILabel!
    var creditLabel:UILabel!
    var GPAWithoutElective:UILabel!
    var GPA:CGFloat{
        set{
            self._GPA = newValue
            self.GPARound.animationWith(GPA: newValue)
        }
        get{
            return _GPA
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        let size:CGFloat = frame.height - StatusBarheight - NavigationHeight - 30 - 20 - 20 - 40
        GPARound = GPARoundView.init(frame: CGRect.init(x: 30, y: 20, width: size, height: size))
        self.view.addSubview(GPARound)
        
        let stack = UIStackView.init()
            //UIStackView.init(frame: CGRect.init(x: 30+size, y: 20, width: ScreenWidth-30-size, height: size))
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually
        semeterLabel = UILabel()
        semeterLabel.text = "第一学期"
        semeterLabel.textColor = .white
        semeterLabel.textAlignment = .center
        semeterLabel.font = UIFont.fontFitWidth(size: 22)
        semeterLabel.backgroundColor = .clear
        stack.addArrangedSubview(semeterLabel)
        classLabel = UILabel()
        classLabel.text = "共修2门课"
        classLabel.textColor = .white
        classLabel.textAlignment  = .center
        classLabel.font = UIFont.fontFitWidth(size: 17)
        stack.addArrangedSubview(classLabel)
        creditLabel = UILabel()
        creditLabel.text = "共计3学分"
        creditLabel.textColor = .white
        creditLabel.textAlignment = .center
        creditLabel.font = UIFont.fontFitWidth(size: 17)
        stack.addArrangedSubview(creditLabel)
        GPAWithoutElective = UILabel()
        GPAWithoutElective.text = "去选修绩点:"
        GPAWithoutElective.textColor = .white
        GPAWithoutElective.textAlignment = .center
        GPAWithoutElective.font = UIFont.fontFitWidth(size: 17)
        stack.addArrangedSubview(GPAWithoutElective)
        
        
        self.view.addSubview(stack)
        stack.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(GPARound.snp_right)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        // Do any additional setup after loading the view.
        
        
        
        
        
    }
    init(frame:CGRect){
        self.frame = frame
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadData(){
        
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
