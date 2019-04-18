//
//  headerForClassSchedule.swift
//  Custed
//
//  Created by faker on 2019/4/17.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class headerForClassSchedule: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    init(itemsHeight:CGFloat,viewHeight:CGFloat){
        super.init(frame: CGRect.init(x: 0, y: 0, width: 15.0, height: viewHeight))
        let lblFontSize:CGFloat = 10.0
        let itemHeight:CGFloat = itemsHeight + 5
        let numberHeight:CGFloat = (itemsHeight-4)/2
        let lineHeight:CGFloat = 2
        let width:CGFloat = 15.0
        let itemSpace = 5
        for i in 0..<6{
            let headerLine = UILabel.init(frame: CGRect.init(x: 0, y: CGFloat(i)*itemHeight, width: width, height: lineHeight))
            headerLine.backgroundColor = UIColor.gray
            let firstElementLabel = UILabel.init(frame: CGRect.init(x: 0, y: CGFloat(i)*itemHeight+lineHeight, width: width, height: numberHeight))
            firstElementLabel.font = UIFont.systemFont(ofSize: lblFontSize)
            firstElementLabel.text = "\((i+1)*2-1)"
            firstElementLabel.textAlignment = .center
            firstElementLabel.backgroundColor = UIColor.white
            let SecondElementLabel = UILabel.init(frame: CGRect.init(x: 0, y: CGFloat(i)*itemHeight+lineHeight+numberHeight, width: width, height: numberHeight))
            SecondElementLabel.font = UIFont.systemFont(ofSize: lblFontSize)
            SecondElementLabel.backgroundColor = UIColor.white
            SecondElementLabel.textAlignment = .center
            SecondElementLabel.text = "\((i+1)*2)"
            let bottomLine = UILabel.init(frame: CGRect.init(x: 0, y: CGFloat(i)*itemHeight+2*numberHeight, width: width, height: lineHeight))
            bottomLine.backgroundColor = UIColor.gray
            self.addSubview(headerLine)
            self.addSubview(firstElementLabel)
            self.addSubview(SecondElementLabel)
            self.addSubview(bottomLine)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
