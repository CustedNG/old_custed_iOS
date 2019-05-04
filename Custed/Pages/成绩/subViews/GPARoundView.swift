//
//  GPARoundView.swift
//  Custed
//
//  Created by faker on 2019/4/26.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
class GPARoundView: UIView {
    var value:CGFloat = 3
    var GPALabel:UILabel!
    var GPAProgress:CAShapeLayer!
    override init(frame: CGRect) {
        self.value = 0
        super.init(frame: frame)
        print("frame",frame)
        self.layer.cornerRadius = frame.width/2
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        let borderWidth = 10*ScreenHeight/896
        let borderPath = UIBezierPath.init(arcCenter: CGPoint.init(x: frame.width/2, y: frame.height/2), radius: (frame.width-borderWidth)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let circluarPath = UIBezierPath.init(arcCenter: CGPoint.init(x: frame.width/2, y: frame.height/2), radius: (frame.width-borderWidth)/2, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi*2 + CGFloat.pi/2, clockwise: true)
        //border layer
        let borderLayer = CAShapeLayer()
        borderLayer.path = borderPath.cgPath
        borderLayer.lineWidth = borderWidth
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.init(white: 1, alpha: 0.2).cgColor
        borderLayer.lineCap = .square
        self.layer.addSublayer(borderLayer)
        
        GPAProgress = CAShapeLayer()
        GPAProgress.path = circluarPath.cgPath
        GPAProgress.lineCap = .round
        GPAProgress.lineWidth = borderWidth
        GPAProgress.fillColor = UIColor.clear.cgColor
        GPAProgress.strokeColor = UIColor.init(white: 1, alpha: 0.6).cgColor
            //UIColor.FromRGB(RGB: 0xB4E5FC).cgColor
        GPAProgress.strokeEnd = 0
        self.layer.addSublayer(GPAProgress)
        GPALabel = UILabel()
        GPALabel.text = "1.2332"
        GPALabel.font = UIFont.fontFitHeight(size: 30)
        GPALabel.sizeToFit()
        GPALabel.textColor = UIColor.FromRGB(RGB: 0xCAEDFD)
        self.addSubview(GPALabel)
        GPALabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        let titleLabel = UILabel()
        titleLabel.text = "本学期绩点"
        titleLabel.textColor = UIColor.FromRGB(RGB: 0xCAEDFD)
        titleLabel.font = UIFont.fontFitHeight(size: 20)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(GPALabel.snp_top)
            make.centerX.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observe")
    }
    func animationWith(GPA:CGFloat){
        self.GPAProgress.strokeEnd = GPA/5.0
        let duration = 3.0*(GPA/5.0)
        let ani = CABasicAnimation.init(keyPath: "strokeEnd")
        ani.fromValue = 0
        ani.toValue = GPA/5.0
        ani.duration = CFTimeInterval(duration)
        self.GPAProgress.add(ani, forKey: "GPAProgressAnimation")
        var count:CGFloat = 0.0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true, block: { (tr) in
            if count >= duration{
                self.GPALabel.text = "\(GPA)"
                tr.invalidate()
            }
            else{
                count += 0.005
                self.GPALabel.text = String.init(format: "%.3f", count*5.0/3.0)
            }
        })
        //add timer to runloop ,or not timer will suspend when chaning current page in PageController
        RunLoop.main.add(timer, forMode: .common)
        timer.fire()
        
    }

}
