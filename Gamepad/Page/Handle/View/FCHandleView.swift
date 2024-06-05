//
//  FCHandleView.swift
//  Gamepad
//
//  Created by chao on 2024/6/5.
//

import UIKit

class FCHandleView: UIView {
    
    lazy var handleItem: HandleItem = {
        let view = HandleItem(frame: CGRect(x: 400, y: 300, width: 200, height: 200))
        return view
    }()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = UIColor.black
        self.addSubview(self.handleItem)
        
        self.handleItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(91)
            make.bottom.equalToSuperview().offset(-35)
            make.size.equalTo(168)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.addSubview(self.handleItem)
        self.handleItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(91)
            make.bottom.equalToSuperview().offset(-35)
            make.size.equalTo(168)
        }
        
    }
    
    
    
    
    
}
