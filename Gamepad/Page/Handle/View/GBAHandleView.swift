//
//  GBAHandleView.swift
//  Gamepad
//
//  Created by chao on 2024/6/6.
//

import UIKit

class GBAHandleView: UIView ,JDPaddleVectorDelegate{

    lazy var handleItem: UIView = {
        let view = UIView(frame: CGRect(x: 400, y: 300, width: 200, height: 200))
        return view
    }()
    
    lazy var backButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "BACK", font: UIFont.systemFont(ofSize: 15.0))
        return button
    }()
    lazy var startButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "START", font: UIFont.systemFont(ofSize: 15.0))
        return button
    }()
    lazy var aButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "A", font: UIFont.boldSystemFont(ofSize: 36))
        button.vibrate = true
        return button
    }()
    lazy var bButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "B", font: UIFont.boldSystemFont(ofSize: 36))
        button.vibrate = true
        return button
    }()
    lazy var xButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "X", font: UIFont.boldSystemFont(ofSize: 36))
        button.vibrate = true
        return button
    }()
    lazy var yButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "Y", font: UIFont.boldSystemFont(ofSize: 36))
        button.vibrate = true
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
        self.addSubview(self.xButton)
        self.addSubview(self.yButton)
        
        self.addSubview(self.handleItem)
        let paddle = MovingPingHandleItem(forUIView: self.handleItem, size: self.handleItem.frame.size)
//        paddle.delegate = self
    }
    func addLayout(){
        
        self.backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview().offset(-(25+30))
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.startButton.snp.makeConstraints { make in
//            make.top.equalTo(self.backButton.snp_topMargin)
            make.centerY.equalTo(self.backButton.snp_centerYWithinMargins)
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
            make.top.equalTo(self.bButton.snp_bottomMargin)
            make.right.equalTo(self.bButton.snp_leftMargin)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.xButton.snp.makeConstraints { make in
            make.right.equalTo(self.aButton.snp_leftMargin)
            make.centerY.equalTo(self.handleItem.snp_centerYWithinMargins)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.yButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.bButton.snp_topMargin)
            make.centerX.equalTo(self.aButton.snp_centerXWithinMargins)
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
    }
    @objc func bClicked() {

    }
    
//    delegete
    func getVector(vector:CGVector)
    {
//        xLabel.text = "x:\(vector.dx)"
//        yLabel.text = "y:\(vector.dy)"
    }
}
