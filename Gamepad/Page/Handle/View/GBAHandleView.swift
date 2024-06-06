//
//  GBAHandleView.swift
//  Gamepad
//
//  Created by chao on 2024/6/6.
//

import UIKit

class GBAHandleView: UIView {

    lazy var handleItem: HandleItem = {
        let view = HandleItem(frame: CGRect(x: 400, y: 300, width: 200, height: 200))
        return view
    }()
    
    
    
    lazy var backButton: UIButton = {
        let button = self.getButton(title: "BACK",font: UIFont.systemFont(ofSize: 15.0))
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    lazy var startButton: UIButton = {
        let button = self.getButton(title: "START",font: UIFont.systemFont(ofSize: 15.0))
        return button
    }()
    lazy var aButton: UIButton = {
        let button = self.getABButton(title: "A",font: UIFont.boldSystemFont(ofSize: 36))
        button.addTarget(self, action: #selector(aClicked), for: .touchUpInside)
        return button
    }()
    lazy var bButton: UIButton = {
        let button = self.getABButton(title: "B",font: UIFont.boldSystemFont(ofSize: 36))
        button.addTarget(self, action: #selector(bClicked), for: .touchUpInside)
        return button
    }()
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.initUI()
    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()

    }
    
    func initUI(){
        self.addUI()
        self.addLayout()
    }
    
    func addUI(){
        self.backgroundColor = UIColor.black
        
        self.addSubview(self.backButton)
        self.addSubview(self.startButton)
        
        self.addSubview(self.aButton)
        self.addSubview(self.bButton)
        
        self.addSubview(self.handleItem)
    }
    func addLayout(){
        
        self.backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview().offset(-(25+30))
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.startButton.snp.makeConstraints { make in
            make.top.equalTo(self.backButton.snp_topMargin)
            make.left.equalTo(self.backButton.snp_rightMargin).offset(48)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.bButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-80)
            make.centerY.equalTo(self.handleItem.snp_centerYWithinMargins)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.aButton.snp.makeConstraints { make in
            make.right.equalTo(self.bButton.snp_leftMargin).offset(-60)
            make.centerY.equalTo(self.bButton.snp_centerYWithinMargins)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.handleItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(91)
            make.bottom.equalToSuperview().offset(-35)
            make.size.equalTo(168)
        }
    }
    
    @objc func backClicked() {
        
    }
    @objc func aClicked() {
        self.aButton.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#0383FF")
        self.bButton.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#303032")
    }
    @objc func bClicked() {
        self.bButton.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#0383FF")
        self.aButton.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#303032")
    }
    
    func getButton(title:String,font:UIFont) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.isHighlighted = true
        button.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#303032")
        
//        let normalBg = UIView()
//        normalBg.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#303032")
        
        return button
    }
    
    func getABButton(title:String,font:UIFont) ->UIButton{
        let button = self.getButton(title: title, font: font)
        return button
    }

}
