//
//  cellsForScheduleVIewCollectionViewCell.swift
//  Custed
//
//  Created by faker on 2019/4/18.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class cellsForScheduleView: UICollectionViewCell {
    var nameLabel:UILabel!
    var positionLabel:UILabel!
    var info:lesson?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        let fontSize:CGFloat = 10*frame.size.width/54.0
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(10)
            make.height.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        positionLabel = UILabel()
        positionLabel.textAlignment = .center
        positionLabel.numberOfLines = 0
        positionLabel.textColor = UIColor.white
        positionLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.addSubview(positionLabel)
        positionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.left.equalTo(nameLabel)
            make.right.equalTo(nameLabel)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
