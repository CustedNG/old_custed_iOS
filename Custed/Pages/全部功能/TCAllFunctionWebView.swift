//
//  TCAllFunctionWebView.swift
//  Custed
//
//  Created by faker on 2019/3/8.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

protocol ButtonPressedDelegate :NSObjectProtocol{
    func click(target: UIView ,index: NSInteger)
}

class TCAllFunctionWebView: UIView {
    weak var btnDelegate:ButtonPressedDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    @objc func footButtonPressed() ->Void{
        btnDelegate?.click(target: self, index: 1)
    }
}
