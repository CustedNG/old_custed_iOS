//
//  TCCollectionViewCell.swift
//  Custed
//
//  Created by faker on 2019/3/10.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCCollectionViewCell: UICollectionViewCell {
    //Uiview
    var imageView : UIImageView?
    var lbl : UILabel?
    var image : SVGKImage?
    let cellWidth : CGFloat = 60/414*ScreenWidth
    let cellLength : CGFloat = 80/414*ScreenWidth
    var lblFontSize : CGFloat{
        get{
            if isIpad {
                return floor(11*Iphone2IpadIamgeScale)
            }
            else{
                return floor(11/414*ScreenWidth)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView.init()
        lbl = UILabel()
        lbl!.backgroundColor = UIColor.white
        lbl?.font = UIFont.systemFont(ofSize: lblFontSize)
        lbl!.textAlignment = NSTextAlignment.center
        self.addSubview(imageView!)
        self.addSubview(lbl!)
        lbl?.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        })
        imageView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((lbl?.snp.top)!).offset(-10)
            make.centerX.equalToSuperview()
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
}
