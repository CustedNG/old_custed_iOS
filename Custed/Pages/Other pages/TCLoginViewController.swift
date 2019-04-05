//
//  TCLoginViewController.swift
//  Custed
//
//  Created by faker on 2019/4/1.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
import Foundation
class TCLoginViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate{
    var passwordTextField = UITextField()
    var accountTextField = UITextField()
    var loginButton = UIButton.init(type: .system)
    var passwordTextFieldFrame : CGRect?
    var accountTextFieldFrame : CGRect?
    var loginShadowLayer : CAShapeLayer?
    var promptBox : UILabel?
    var accountShadowLayer : CAShapeLayer?
    var passwordShadowLayer : CAShapeLayer?
    let shadowColor = UIColor.FromRGB(RGB: 0x5CA9F3)
    let promptColor = UIColor.FromRGB(RGB: 0xDF4C65)
    let promptBackgroundColor = UIColor.FromRGB(RGB: 0xFFE4E8)
    let borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)
    let explainFontSize = UIFont.systemFont(ofSize: 11)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //返回
        let backImage = UIImageView.init(image: UIImage.init(named: "widget_week_open.png"))
        //backImage.tintColor = UIColor.FromRGB(RGB: 0x5CA9F3)
        backImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(clicked))
        backImage.addGestureRecognizer(gesture)
        self.view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(StatusBarheight)
            make.left.equalToSuperview().offset(compactWidth)
        }
        //logo
        let logoImage = UIImageView.init(image: UIImage.init(named: "custedLogo.png"))
        self.view.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(backImage.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 389/4, height: 292/4))
        }
        //吐司工作室 - let us imagine
        let label1 = UILabel.init()
        label1.text = "吐司工作室 - Let us imagine"
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 21)
        self.view.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        //源于学生的高级技术开发团队
        let label2 = UILabel.init()
        label2.text = "源于学生的高级技术开发团队"
        label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        //账号textfield
        accountTextField.delegate = self
        accountTextField.tag = 0
        accountTextField.keyboardType = .numberPad
        accountTextField.backgroundColor = UIColor.white
        accountTextField.alpha = 1
        accountTextField.placeholder = "一卡通账号(如:2016001234)"
        accountTextField.backgroundColor = .white
        accountTextField.layer.cornerRadius = 5
        accountTextField.layer.borderWidth = 1
        accountTextField.layer.borderColor = borderColor.cgColor
        accountTextField.layer.shadowRadius = 0
        accountTextField.layer.shadowOpacity = 1
        accountTextField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        accountTextField.layer.shadowColor = shadowColor.cgColor
        let accountImage = SVGKImage.init(named: "custedid.svg")
        accountImage?.size = CGSize.init(width: 20, height: 20)
        let accountImageView = UIImageView.init(image: accountImage?.uiImage)
        accountImageView.frame = CGRect.init(x: 5, y: 0, width: 20, height: 20)
        accountTextField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 20))
        accountTextField.leftView?.addSubview(accountImageView)
        accountTextField.leftViewMode = .always
        self.view.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: ScreenWidth*4/5, height: 35))
        }
        //密码textfield
        passwordTextField.delegate = self
        passwordTextField.tag = 1
        passwordTextField.placeholder = "教务系统密码"
        passwordTextField.keyboardType = .numbersAndPunctuation
        let passwordImage = SVGKImage.init(named: "custedpassword.svg")
        passwordImage?.size = CGSize.init(width: 20, height: 20)
        let passwordImageView = UIImageView.init(image: passwordImage?.uiImage)
        passwordImageView.frame = CGRect.init(x: 5, y: 0, width: 20, height: 20)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 20))
        passwordTextField.leftView?.addSubview(passwordImageView)
        passwordTextField.leftViewMode = .always
        //一定他妈的要设置背景颜色，不然shadow就是你妈不出来
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = borderColor.cgColor
        passwordTextField.layer.shadowRadius = 0
        passwordTextField.layer.shadowOpacity = 1
        passwordTextField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        passwordTextField.layer.shadowColor = shadowColor.cgColor
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(accountTextField.snp.bottom).offset(8)
            make.size.equalTo(CGSize.init(width: ScreenWidth*4/5, height: 35))
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginButton.backgroundColor = shadowColor
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("开  始  体  验", for: .normal)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowColor = shadowColor.cgColor
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }
        
        //登陆系统，即代表你同意 《Custed软件许可及服务协议》
        let label3 = UITextView.init()
        let text = "登陆系统，即代表你同意 《Custed软件许可及服务协议》"
        let attributeText = NSMutableAttributedString.init(string: text)
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.link : "https://blog.tusi.site/serviceagreement.html",
            NSAttributedString.Key.foregroundColor: UIColor.green,
            NSAttributedString.Key.underlineColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 0]
        attributeText.addAttributes(linkAttributes, range: NSRange.init(location: 12, length: 17))
        label3.attributedText = attributeText
        label3.isEditable = false
        label3.textAlignment = .center
        label3.textColor = .gray
        label3.font = explainFontSize
        self.view.addSubview(label3)
        label3.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp_bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        //Designed By Toast & app.cust.edu.cn 2016-2019
        let label5 = UILabel()
        label5.textAlignment = .center
        label5.textColor = .gray
        label5.font = explainFontSize
        let attrStr = NSMutableAttributedString.init(string: "Designed By Toast & app.cust.edu.cn 2016-2019")
        let app : [NSAttributedString.Key:Any] = [
            NSMutableAttributedString.Key.underlineColor : UIColor.black,
            NSMutableAttributedString.Key.foregroundColor : UIColor.black,
            NSMutableAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        attrStr.addAttributes(app, range: NSRange.init(location: 20, length: 15))
        label5.attributedText = attrStr
        self.view.addSubview(label5)
        label5.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        //Custed - Let us imagine
        let label4 = UILabel()
        label4.text = "Custed - Let us imagine"
        label4.textAlignment = .center
        label4.font = explainFontSize
        label4.textColor = .gray
        self.view.addSubview(label4)
        label4.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(label5.snp_top)
        }
        
        //提示框
        promptBox = UILabel()
        promptBox?.isHidden = true
        promptBox?.textAlignment = .center
        promptBox?.backgroundColor = promptBackgroundColor
        promptBox?.textColor = promptColor
        
        //边框颜色
        promptBox?.layer.borderWidth = 1
        promptBox?.layer.borderColor = promptColor.cgColor
        
        promptBox?.layer.shadowColor = promptColor.cgColor
        promptBox?.layer.shadowOffset = .zero
        promptBox?.layer.shadowOpacity = 1
        promptBox?.layer.shadowRadius = 8
        self.view.addSubview(promptBox!)
        promptBox?.snp.makeConstraints({ (make) in
            make.size.equalTo(loginButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(label3.snp_bottom).offset(15)
        })
        
    }
    @objc func clicked(){
        print("点击")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func loginButtonClicked(){
        if accountTextField.text!.isEmpty{
            promptBox?.isHidden = false
            promptBox?.text = "账 号 不 能 为 空"
            return
        }
        else if passwordTextField.text!.isEmpty{
            promptBox?.isHidden = false
            promptBox?.text = "密 码 不 能 为 空"
            return
        }
        TCNetWorkingManager.shared.updateOrGettingID(id: accountTextField.text!, pass: passwordTextField.text!) { (result) in
            self.promptBox?.isHidden = false
            self.promptBox?.text = result
        }
    }
    override func viewDidLayoutSubviews() {
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = shadowColor.cgColor
        textField.layer.shadowRadius = 8
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //textField.layer.sublayers?.first?.removeFromSuperlayer()
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.shadowRadius = 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    
}

