//
//  TCScheduleDataPicker.swift
//  Custed
//
//  Created by 朱超然 on 2019/4/26.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
class CustedDataPickerView:UIView,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var CustedDataPicker: UIPickerView!
    var PickerView: UIView!
    var PickerBackgroundView: UIView!
    var showedCustedDataPickerFrame:CGRect!
    
    
    let dataName = ["第1周","第2周","第3周","第4周","第5周","第6周","第7周","第8周","第9周","第10周","第11周","第12周","第13周","第14周","第15周","第16周","第17周","第18周","第19周","第20周","第21周","第22周","第23周","第24周"]
    
    
        //初始化
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        //
        
//        self.backgroundColor = .clear
//        let backgroundView = UIView()
//        backgroundView.layer.cornerRadius = 15
//        backgroundView.frame = self.frame
//        backgroundView.backgroundColor = UIColor.clear
//        self.addSubview(backgroundView)
        
        //给滚轮的背景
        PickerBackgroundView = UIView()
        PickerBackgroundView.layer.cornerRadius = 15
        self.addSubview(PickerBackgroundView)

        //滚轮
        PickerView = UIView()
        PickerView.backgroundColor = nil
        PickerView.layer.cornerRadius = 15
        PickerView.isHidden = true
        self.addSubview(PickerView)
        PickerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        CustedDataPicker = UIPickerView()
        CustedDataPicker.backgroundColor = UIColor.blue
        CustedDataPicker.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 256)
        CustedDataPicker.isUserInteractionEnabled = true
        CustedDataPicker.delegate = self
        CustedDataPicker.dataSource = self
        PickerView.addSubview(CustedDataPicker)
        
        
        let ConfirmButton: UIButton = UIButton(type: .custom)
        ConfirmButton.frame = CGRect(x: 100, y: 200, width: 100, height: 30)
        ConfirmButton.setTitle("确定日期", for: .selected)
        ConfirmButton.setTitle("请确定日期", for: .normal)
        ConfirmButton.backgroundColor = UIColor.black
        ConfirmButton.addTarget(self, action: #selector(clickConfirmButton), for: .touchUpInside)
        PickerView.addSubview(ConfirmButton)
        
        self.isHidden = false
        let windows = UIApplication.shared.delegate?.window
        windows!!.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickConfirmButton(){
        
        let row = CustedDataPicker.selectedRow(inComponent: 0)
        let selected = dataName[row]
        //中间有一系列传值切换视图操作----------------
        
        self.PickerView.isHidden = true
        self.isHidden = true
    }
    
    @objc func showCustedDataPickerView(){
        self.isHidden = false
        self.isUserInteractionEnabled = true
        self.PickerView.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataName.count
    }
    
    func pickerView(_ pickerView: UIPickerView , titleForRow row: Int,forComponent component:Int) -> String? {
        return dataName[row]
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }


}

